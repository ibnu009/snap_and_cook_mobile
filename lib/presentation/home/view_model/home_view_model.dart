import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/general/recipe_use_case.dart';

import '../../../domain/entities/recipe.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String version = "Version 0.0.1-dev";

  TextEditingController searchController = TextEditingController();
  final RecipeUseCase _recipeUseCase = RecipeUseCase();

  final RxList<Recipe>  recipes = RxList<Recipe>();

  void onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void onInit() {
    super.onInit();
    _fetchAllRecipes();
  }

  Future<void> _fetchAllRecipes() async {
    showLoadingContainer();
    var data = await _recipeUseCase.fetchRecipes(cancelToken);
    data.fold((l){
    }, (result){
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

  @override
  void onClose() {}
}
