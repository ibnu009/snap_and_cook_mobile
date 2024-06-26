import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/resources/arguments/argument_constants.dart';
import 'package:snap_and_cook_mobile/routes/routes/main_route.dart';
import 'package:snap_and_cook_mobile/utils/detection/labels.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../components/camera/custom_camera.dart';
import '../../../domain/use_case/utensils/utensil_use_case.dart';
import '../../../resources/constants/session_constants.dart';
import '../../../utils/detection/yolo.dart';
import '../../../utils/session/session.dart';
import '../../base/base_view_model.dart';
import '../components/tutorial_detection_idle_items.dart';

class RecipeDetectionViewModel extends BaseViewModel {
  RxList<Map<String, dynamic>> modelResults = RxList();
  final _utensilUseCase = UtensilUseCase();
  final buttonKey = GlobalKey();

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

  double confidenceThreshold = 0.3;
  double iouThreshold = 0.4;

  RxList<List<double>> inferenceOutput = RxList();
  RxList<int> classes = RxList();
  RxList<List<double>> bboxes = RxList();
  RxList<double> scores = RxList();
  RxString detectionTime = RxString("");

  Rxn<Uint8List> imageBytes = Rxn<Uint8List>();
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  final YoloModel model = YoloModel(
    'assets/yolov8m_snapcook.tflite',
    inModelWidth,
    inModelHeight,
    numClasses,
  );

  late TutorialCoachMark tutorialCoachMark;

  BuildContext? pageContext;

  @override
  void onInit() {
    super.onInit();
    _loadMachineLearningModel();
    createTutorial();
    showTutorial();
  }

  void getPageContext(BuildContext context){
    pageContext = context;
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: createDetectionIdleTutorialTargets(
          keyBottomNavigation1: buttonKey,),
      colorShadow: Colors.black38,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        Session.set(SessionConstants.isAlreadyOnBoardingDetectIngredient, "yes");
      },
      onClickTarget: (target) {},
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        Session.set(SessionConstants.isAlreadyOnBoardingDetectIngredient, "yes");
        return true;
      },
    );
  }

  Future<void> showTutorial() async {
    Future.delayed(const Duration(seconds: 1));
    String? isOnBoarded = await Session.get(SessionConstants.isAlreadyOnBoardingDetectIngredient);
    if (isOnBoarded != null) {
      return;
    }

    if (pageContext?.mounted ?? false){
      tutorialCoachMark.show(context: pageContext!);
    }
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

  Future<bool> _isUtensilEmpty() async {
    var utensils = await _utensilUseCase.fetchSelectedUtensils();
    return utensils.isEmpty;
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
    var isEmpty = await _isUtensilEmpty();
    if (isEmpty){
      Get.snackbar("Peringatan", "Kamu belum memilih alat memasak");
      return;
    }

    File? data = await Navigator.of(Get.context!).push(
      MaterialPageRoute<File>(
        builder: (BuildContext context) =>
            const CustomCameraWidget(compressionQuality: 80),
      ),
    );

    if (data != null) {
      imageFile.value = data;
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
    int predictionTimeStart = DateTime.now().millisecondsSinceEpoch;

    inferenceOutput.value = await model.inferenceImage(image);
    detectionTime.value = "Prediction time: ${DateTime.now().millisecondsSinceEpoch - predictionTimeStart} ms";
    closeLoadingDialog();

    updatePostProcess();
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


