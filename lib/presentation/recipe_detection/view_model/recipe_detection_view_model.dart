import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/resources/arguments/argument_constants.dart';
import 'package:snap_and_cook_mobile/routes/routes/main_route.dart';

import '../../../components/camera/custom_camera.dart';
import '../../../utils/helper/detection_helper.dart';
import '../../base/base_view_model.dart';

class RecipeDetectionViewModel extends BaseViewModel {
  final FlutterVision _vision = FlutterVision();
  RxList<Map<String, dynamic>> modelResults = RxList();
  Rxn<File> imageFile = Rxn<File>();
  RxInt imageHeight = RxInt(1);
  RxInt imageWidth = RxInt(1);
  RxBool isLoadingModel = RxBool(false);
  RxBool isProcessingModel = RxBool(false);
  RxBool isShowDetectionResult = RxBool(false);
  RxList<Ingredient> detectedIngredients = RxList();
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  Rxn<Uint8List> imageBytes = Rxn<Uint8List>();
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  @override
  void onInit() {
    super.onInit();
    _loadMachineLearningModel();
  }

  Future<void> _loadMachineLearningModel() async {
    showLoadingContainer();
    await _vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/yolov8m_float16.tflite',
      // labels: 'assets/labels_alpha.txt',
      // modelPath: 'assets/wicaratanganV2.tflite',
      modelVersion: "yolov8",
      quantization: false,
      numThreads: 2,
      useGpu: true,
    );
    hideLoadingContainer();
  }

  Future<void> pickImage() async {
    File? data = await Navigator.of(Get.context!).push(
      MaterialPageRoute<File>(
        builder: (BuildContext context) =>
            const CustomCameraWidget(compressionQuality: 80),
      ),
    );

    if (data != null) {
      imageFile.value = data;
      _startTimer();
      _detectIngredients();
    }
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("${_stopwatch.elapsed.inSeconds} seconds");
    });
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
    if (result.isNotEmpty) {
      modelResults.value = result;
      imageBytes.value = await drawOnImage(modelResults);
      closeLoadingDialog();
      _showDraggableBottomSheet();
      _timer?.cancel();
      _stopwatch.stop();
      _stopwatch.reset();
    } else {
      _timer?.cancel();
      _stopwatch.stop();
      _stopwatch.reset();
      closeLoadingDialog();
      showGeneralDialog(context: Get.context!, pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
          title: const Text("Tidak ada bahan yang terdeteksi"),
          content: const Text("Silahkan coba lagi"),
          actions: [
            TextButton(onPressed: () {
              Get.back();
            }, child: const Text("OK"))
          ],
        );
      });
    }
  }

  void incrementIngredientQuantity(int index) {
    detectedIngredients[index].quantity =
        (detectedIngredients[index].quantity ?? 0) + 1;
    detectedIngredients.refresh();
  }

  void decrementIngredientQuantity(int index) {
    if (detectedIngredients[index].quantity == 1) return;
    detectedIngredients[index].quantity =
        (detectedIngredients[index].quantity ?? 0) - 1;
    detectedIngredients.refresh();
  }

  void removeIngredient(int index) {
    detectedIngredients.removeAt(index);
    detectedIngredients.refresh();
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
    List<Ingredient> detectedObject =
        drawBoxesOnCanvasAndReturnDetectedIngredient(
      canvas: canvas,
      screen: Size(img.width.toDouble(), img.height.toDouble()),
      modelResults: modelResults,
      imageHeight: imageHeight.value,
      imageWidth: imageWidth.value,
    );

    detectedIngredients.value = detectedObject;

    final picture = recorder.endRecording();
    final imgWithBoxes = await picture.toImage(img.width, img.height);
    final ByteData? byteData =
        await imgWithBoxes.toByteData(format: ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  void _showDraggableBottomSheet() {
    isShowDetectionResult.value = true;
    if (!draggableScrollableController.isAttached) return;
    draggableScrollableController.animateTo(
      0.5,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void navigateToRecipeDetectionResult() {
    Get.toNamed(MainRoute.detectionResult, arguments: {
      ArgumentConstants.ingredients: detectedIngredients.value,
    });
  }

  @override
  void onClose() {
    _vision.closeYoloModel();
    super.onClose();
  }
}
