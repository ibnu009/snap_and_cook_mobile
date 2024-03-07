import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/general/recipe_use_case.dart';

import '../../../data/remote/models/ingredient_model.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/use_case/utensils/utensil_use_case.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class RecipeSearchResultViewModel extends BaseViewModel {
  final _recipeUseCase = RecipeUseCase();
  TextEditingController searchController = TextEditingController();

  final _argument = Get.arguments as Map<String, dynamic>;

  String search = "";

  final RxList<String> selectedUtensil = RxList();
  final RxList<Recipe> recipes = RxList<Recipe>();

  @override
  void onInit() {
    super.onInit();
    search = _argument[ArgumentConstants.search] as String;
    searchController.text = search;
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    showLoadingContainer();
    var data = await _recipeUseCase.fetchRecipes(cancelToken, size: 20, currentPage: 1, search: search);
    data.fold((l) {
      hideLoadingContainer();
    }, (result) {
      hideLoadingContainer();
      recipes.clear();
      recipes.addAll(result);
    });
  }

  void onSearchSubmitted(String value) {
    search = value;
    _fetchRecipes();
  }

  void navigateToRecipeDetail(String uuid) {
    Get.toNamed(MainRoute.detail,
        arguments: {ArgumentConstants.recipeUuid: uuid});
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
