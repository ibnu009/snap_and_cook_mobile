library camera_with_files;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import "package:intl/intl.dart";
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomCameraWidget extends StatefulWidget {
  final int? compressionQuality;

  const CustomCameraWidget({Key? key, this.compressionQuality = 100}) : super(key: key);

  @override
  CustomCameraWidgetState createState() => CustomCameraWidgetState();
}

class CustomCameraWidgetState extends State<CustomCameraWidget> {
  CameraController? controller;
  late List<CameraDescription> cameras;
  bool flashOn = false;
  bool showPerformance = false;

  @override
  void initState() {
    super.initState();
    cameraLoad();
  }

  cameraLoad() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max,
        imageFormatGroup: Platform.isIOS ? ImageFormatGroup.bgra8888 : null);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _promptPermissionSetting().then((_) {
        if (_) {}
        setState(() {});
      });
      setState(() {});
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (kIsWeb) {
      return true;
    } else if (Platform.isIOS) {
      PermissionStatus status = await Permission.storage.request();
      PermissionStatus status2 = await Permission.photos.request();
      PermissionStatus status3 = await Permission.mediaLibrary.request();
      return status.isGranted && status2.isGranted && status3.isGranted;
    } else if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.request();
      return status.isGranted;
    }
    return false;
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }
    var camera = controller!.value;
    final size = MediaQuery.of(context).size;
    var scale = 0.0;
    try {
      scale = size.aspectRatio * camera.aspectRatio;
    } catch (e) {
      debugPrint(e.toString());
    }

    if (scale < 1) scale = 1 / scale;

    if (!controller!.value.isInitialized) {
      return Container();
    }
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onVerticalDragStart: (e) {},
              child: Transform.scale(
                scale: scale,
                child: Center(
                  child: CameraPreview(controller!),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 215,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _galleryButton(),
                    _cameraButton(),
                    SizedBox(width: 25,)
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              flashOn = !flashOn;
                              if (flashOn) {
                                controller!.setFlashMode(FlashMode.torch);
                              } else {
                                controller!.setFlashMode(FlashMode.off);
                              }
                            });
                          },
                          icon: const Icon(Icons.flash_off,
                              size: 30, color: Colors.white)),
                      IconButton(
                          onPressed: () {
                            compress(null);
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _galleryButton(){
    return IconButton(
      onPressed: () async {
        final ImagePicker picker0 =
        ImagePicker();
        final XFile? image =
        await picker0.pickImage(
            source: ImageSource.gallery);
        if (image == null) {
          return;
        }
        File file = File(image.path);
        compress(file);
      },
      icon: const Icon(Icons.photo_library,
          size: 30, color: Colors.white),
    );
  }

  Widget _cameraButton(){
    return GestureDetector(
      onTap: () async {
        XFile file2 = await controller!.takePicture();
        File file = File(file2.path);
        compress(file);
      },
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          // color: Colors.white,
            borderRadius: const BorderRadius.all(
                Radius.circular(
                    50)
            ),
            border: Border.all(
                color: Colors.white, width: 3)),
      ),
    );
  }

  void onSettingCallback() {
    setState(() {
      showPerformance = !showPerformance;
    });
  }

  void compress(File? file) async {
    if (file == null) {
      Navigator.of(context).pop(null);
    }
    File? files2;
    Uint8List? blobBytes = await compressFile(file!);
    var dir = await getTemporaryDirectory();
    String trimmed = dir.absolute.path;
    String dateTimeString = DateTime.now().millisecondsSinceEpoch.toString();
    String pathString = "$trimmed/$dateTimeString.jpg";
    File fileNew = File(pathString);
    fileNew.writeAsBytesSync(List.from(blobBytes!));
    files2 = fileNew;

    if (context.mounted) {
      Navigator.of(context).pop(files2);
    }
  }

  String dateTimeToString(DateTime dateTime, String pattern) {
    final format = DateFormat(pattern);
    return format.format(dateTime);
  }

  Future<Uint8List?> compressFile(File file) async {
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    print("Image compress Before: " +
        getFileSizeString(bytes: file.lengthSync()));
    var result = await FlutterImageCompress.compressWithFile(file.absolute.path,
        minHeight: decodedImage.height,
        minWidth: decodedImage.width,
        quality: widget.compressionQuality!);
    print("Image compress After: " +
        getFileSizeString(bytes: result!.lengthInBytes));
    return result;
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
