import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/resources/arguments/argument_constants.dart';
import 'package:snap_and_cook_mobile/routes/routes/main_route.dart';
import 'package:snap_and_cook_mobile/utils/detection/labels.dart';

import '../../../components/camera/custom_camera.dart';
import '../../../utils/detection/yolo.dart';
import '../../base/base_view_model.dart';

class RecipeDetectionViewModel extends BaseViewModel {
  RxList<Map<String, dynamic>> modelResults = RxList();
  Rxn<File> imageFile = Rxn<File>();
  RxnInt imageHeight = RxnInt();
  RxnInt imageWidth = RxnInt();
  RxBool isLoadingModel = RxBool(false);
  RxBool isProcessingModel = RxBool(false);
  RxBool isShowDetectionResult = RxBool(false);
  RxList<Ingredient> detectedIngredients = RxList();
  final Stopwatch _stopwatch = Stopwatch();

  static const inModelWidth = 640;
  static const inModelHeight = 640;
  static const numClasses = 6;

  double maxImageWidgetHeight = 400;

  double confidenceThreshold = 0.20;
  double iouThreshold = 0.1;

  RxList<List<double>> inferenceOutput = RxList();
  RxList<int> classes = RxList();
  RxList<List<double>> bboxes = RxList();
  RxList<double> scores = RxList();

  // int? imageWidth;
  // int? imageHeight;

  Rxn<Uint8List> imageBytes = Rxn<Uint8List>();
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  final YoloModel model = YoloModel(
    'assets/yolov8.tflite',
    inModelWidth,
    inModelHeight,
    numClasses,
  );

  @override
  void onInit() {
    super.onInit();
    _loadMachineLearningModel();
  }

  Future<void> _loadMachineLearningModel() async {
    showLoadingContainer();
    await model.init();
    hideLoadingContainer();
  }

  void _resetBounding(){
    classes.clear();
    bboxes.clear();
    scores.clear();
  }

  Future<void> updatePostProcess() async {
    detectedIngredients.clear();
    if (inferenceOutput.isEmpty) {
      return;
    }

    List<int> newClasses = [];
    List<List<double>> newBboxes = [];
    List<double> newScores = [];

    /// Wait this process with loading
    (newClasses, newBboxes, newScores) = await model.postprocess(
      inferenceOutput,
      imageWidth.value ?? 0,
      imageHeight.value ?? 0,
      confidenceThreshold: confidenceThreshold,
      iouThreshold: iouThreshold,
    );

    debugPrint('Detected ${newClasses} classes');
    debugPrint('Detected ${newBboxes.length} boxed');
    debugPrint('Detected ${newScores.length} scores');

    classes.value = newClasses;
    bboxes.value = newBboxes;
    scores.value = newScores;
    hideLoadingContainer();

    for (var element in newClasses) {
      if (detectedIngredients.isEmpty){
        detectedIngredients.add(Ingredient(
          name: labels[element],
          quantity: 1,
        ));
      } else {
        bool isExist = false;
        for (int i = 0; i < detectedIngredients.length; i++) {
          if (detectedIngredients[i].name == labels[element]) {
            detectedIngredients[i].quantity = detectedIngredients[i].quantity! + 1;
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          detectedIngredients.add(Ingredient(
            name: labels[element],
            quantity: 1,
          ));
        }
      }
    }

    // closeLoadingDialog();
    _showDraggableBottomSheet();
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
      // _startTimer();
      _resetBounding();
      _detectIngredients();
    }
  }

  void _startTimer() {
    _stopwatch.start();
  }

  void _detectIngredients() async {
    showLoadingDialog();
    final image = img.decodeImage(await imageFile.value!.readAsBytes())!;

    imageHeight.value = image.height;
    imageWidth.value = image.width;
    inferenceOutput.value = await model.inferenceImage(image);
    closeLoadingDialog();

    updatePostProcess();


    // final result = await _vision.yoloOnImage(
    //   bytesList: byte,
    //   imageHeight: image.height,
    //   imageWidth: image.width,
    //   iouThreshold: 0.2,
    //   confThreshold: 0.2,
    //   classThreshold: 0.2,
    // );

    // print("DATA IS ${result.length}");
    // if (result.isNotEmpty) {
    // } else {
    //   _timer?.cancel();
    //   _stopwatch.stop();
    //   _stopwatch.reset();
    //   closeLoadingDialog();
    //   showGeneralDialog(context: Get.context!, pageBuilder: (context, anim1, anim2) {
    //     return AlertDialog(
    //       title: const Text("Tidak ada bahan yang terdeteksi"),
    //       content: const Text("Silahkan coba lagi"),
    //       actions: [
    //         TextButton(onPressed: () {
    //           Get.back();
    //         }, child: const Text("OK"))
    //       ],
    //     );
    //   });
    // }
  }


  final translationDict = {
    'carrot': 'Wortel',
  };

  Ingredient translateIngredient(Ingredient ingredient, Map<String, String> translationDict) {
    final translatedName = translationDict[ingredient.name] ?? ingredient.name;
    return Ingredient(
      name: translatedName,
      quantity: ingredient.quantity,
      unit: ingredient.unit,
    );
  }

  List<Ingredient> translateIngredients(List<Ingredient> ingredients, Map<String, String> translationDict) {
    return ingredients.map((ingredient) => translateIngredient(ingredient, translationDict)).toList();
  }

  // List<String> translateIngredients(List<Ingredient> originalList) {
  //   return originalList.map((Ingredient item) => item.name?.replaceAll('carrot', 'wortel')).toList();
  // }

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

  // Future<Uint8List> drawOnImage(List<Map<String, dynamic>> modelResults) async {
  //   final image = imageFile.value;
  //   if (image == null) {
  //     return Uint8List(0);
  //   }
  //
  //   final imgBytes = image.readAsBytesSync();
  //   final img = await decodeImageFromList(Uint8List.fromList(imgBytes));
  //
  //   final recorder = PictureRecorder();
  //   final canvas = Canvas(recorder);
  //   canvas.drawImage(img, Offset.zero, Paint());
  //   List<Ingredient> detectedObject =
  //       drawBoxesOnCanvasAndReturnDetectedIngredient(
  //     canvas: canvas,
  //     screen: Size(img.width.toDouble(), img.height.toDouble()),
  //     modelResults: modelResults,
  //     imageHeight: imageHeight.value,
  //     imageWidth: imageWidth.value,
  //   );
  //
  //   detectedIngredients.value = translateIngredients(detectedObject, translationDict);
  //
  //   // detectedIngredients.value = detectedObject;
  //
  //   final picture = recorder.endRecording();
  //   final imgWithBoxes = await picture.toImage(img.width, img.height);
  //   final ByteData? byteData =
  //       await imgWithBoxes.toByteData(format: ImageByteFormat.png);
  //
  //   return byteData!.buffer.asUint8List();
  // }

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
    super.onClose();
  }
}


