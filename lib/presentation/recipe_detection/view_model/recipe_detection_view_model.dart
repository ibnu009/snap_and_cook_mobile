import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/base_view_model.dart';

class RecipeDetectionViewModel extends BaseViewModel {
  final FlutterVision _vision = FlutterVision();
  RxList<Map<String, dynamic>> modelResults = RxList();
  Rxn<File> imageFile = Rxn<File>();
  RxInt imageHeight = RxInt(1);
  RxInt imageWidth = RxInt(1);
  RxBool isLoadingModel = RxBool(false);
  RxBool isProcessingModel = RxBool(false);
  Rxn<Uint8List> imageBytes = Rxn<Uint8List>();

  @override
  void onInit() {
    super.onInit();
    _loadMachineLearningModel();
  }

  Future<void> _loadMachineLearningModel() async {
    isLoadingModel.value = true;
    await _vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/yolov8m_float16.tflite',
      modelVersion: "yolov8",
      quantization: false,
      numThreads: 2,
      useGpu: true,
    );
    isLoadingModel.value = false;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      imageFile.value = File(photo.path);
      _detectIngredients();
    }
  }

  void _detectIngredients() async {
    modelResults.clear();
    Uint8List byte = await imageFile.value!.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight.value = image.height;
    imageWidth.value = image.width;

    showLoadingDialog();
    final result = await _vision.yoloOnImage(
      bytesList: byte,
      imageHeight: image.height,
      imageWidth: image.width,
      iouThreshold: 0.8,
      confThreshold: 0.2,
      classThreshold: 0.3,
    );
    closeLoadingDialog();
    if (result.isNotEmpty) {
      modelResults.value = result;
      imageBytes.value = await drawOnImage( modelResults);
    }
  }

  Future<Uint8List> drawOnImage(List<Map<String, dynamic>> modelResults) async {
    final image = imageFile.value;
    if (image == null) {
      return Uint8List(0);
    }

    final imgBytes = image.readAsBytesSync();
    final img = await decodeImageFromList(Uint8List.fromList(imgBytes));

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawImage(img, Offset.zero, Paint());
    drawBoxesOnCanvas(canvas, Size(img.width.toDouble(), img.height.toDouble()), modelResults);

    final picture = recorder.endRecording();
    final imgWithBoxes = await picture.toImage(img.width, img.height);
    final ByteData? byteData = await imgWithBoxes.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  void drawBoxesOnCanvas(Canvas canvas, Size screen, List<Map<String, dynamic>> modelResults) {
    if (modelResults.isEmpty) return;

    double factorX = screen.width / imageWidth.value;
    double imgRatio = imageWidth.value / imageHeight.value;
    double newWidth = imageWidth.value * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / imageHeight.value;

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    final Paint boxPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint textBackgroundPaint = Paint()
      ..color = colorPick;

    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 28.0,
    );

    for (Map<String, dynamic> result in modelResults) {
      double left = result["box"][0] * factorX;
      double top = result["box"][1] * factorY + pady;
      double width = (result["box"][2] - result["box"][0]) * factorX;
      double height = (result["box"][3] - result["box"][1]) * factorY;

      Rect rect = Rect.fromLTWH(left, top, width, height);
      canvas.drawRect(rect, boxPaint);

      TextSpan textSpan = TextSpan(
        text: "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
        style: textStyle,
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      Offset textOffset = Offset(left, top - textPainter.height - 2.0);

      Rect textBackgroundRect = Rect.fromPoints(
        Offset(textOffset.dx, textOffset.dy),
        Offset(textOffset.dx + textPainter.width, textOffset.dy + textPainter.height),
      );
      canvas.drawRect(textBackgroundRect, textBackgroundPaint);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  void onClose() {
    _vision.closeYoloModel();
    super.onClose();
  }
}
