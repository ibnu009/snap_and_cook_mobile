import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/general/recipe_use_case.dart';
import 'package:snap_and_cook_mobile/resources/constants/session_constants.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../domain/entities/recipe.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../../utils/session/session.dart';
import '../../base/base_view_model.dart';
import '../components/tutorial_home_items.dart';

class HomeViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();
  final RecipeUseCase _recipeUseCase = RecipeUseCase();

  final RxList<Recipe> recipes = RxList<Recipe>();
  late TutorialCoachMark tutorialCoachMark;

  BuildContext? pageContext;

  final cameraKey = GlobalKey();
  final searchKey = GlobalKey();
  final settingKey = GlobalKey();

  void onSearchSubmitted(String value) {
    if (value.isEmpty) {
      return;
    }
    Get.toNamed(MainRoute.searchResult,
        arguments: {ArgumentConstants.search: value});
  }

  @override
  void onInit() {
    super.onInit();
    _fetchAllRecipes();
    createTutorial();
    showTutorial();
  }


  void getPageContext(BuildContext context){
    pageContext = context;
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: createTargets(
          keyBottomNavigation1: cameraKey,
          keyBottomNavigation2: searchKey,
          keyBottomNavigation3: settingKey),
      colorShadow: Colors.black38,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
        Session.set(SessionConstants.isAlreadyOnBoardingHome, "yes");
      },
      onClickTarget: (target) {
      },
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        Session.set(SessionConstants.isAlreadyOnBoardingHome, "yes");
        return true;
      },
    );
  }

  Future<void> showTutorial() async {
    Future.delayed(const Duration(seconds: 1));
    String? isOnBoarded = await Session.get(SessionConstants.isAlreadyOnBoardingHome);
    if (isOnBoarded != null) {
      return;
    }

    if (pageContext?.mounted ?? false){
      tutorialCoachMark.show(context: pageContext!);
    }
  }

  Future<void> _fetchAllRecipes() async {
    showLoadingContainer();
    var data = await _recipeUseCase.fetchRecipes(cancelToken,
        size: 20, currentPage: 1);
    data.fold((l) {}, (result) {
      hideLoadingContainer();
      recipes.clear();
      recipes.addAll(result);
    });
  }

  void navigateToRecipeDetail(String uuid) {
    Get.toNamed(MainRoute.detail, arguments: {
      ArgumentConstants.recipeUuid: uuid,
    });
  }

  void navigateToRecipeDetection() {
    Get.toNamed(MainRoute.detection);
  }

  void navigateToUtensilPage() {
    Get.toNamed(MainRoute.utensil);
  }

  @override
  void onClose() {}
}
