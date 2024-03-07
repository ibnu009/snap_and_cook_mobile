import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/general/recipe_use_case.dart';

import '../../../data/remote/models/ingredient_model.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/use_case/utensils/utensil_use_case.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class RecipeDetectionResultViewModel extends BaseViewModel {
  final _utensilUseCase = UtensilUseCase();
  final _recipeUseCase = RecipeUseCase();

  final _argument = Get.arguments as Map<String, dynamic>;

  final List<Ingredient> ingredients = [];

  final RxList<String> selectedUtensil = RxList();
  final RxList<Recipe>  recipes = RxList<Recipe>();

  @override
  void onInit() {
    super.onInit();
    ingredients
        .addAll(_argument[ArgumentConstants.ingredients] as List<Ingredient>);

    _fetchRecipeRecommendation();
  }

  Future<void> _fetchSelectedUtensil() async {
    selectedUtensil.value = await _utensilUseCase.fetchSelectedUtensils();
  }

  Future<void> _fetchRecipeRecommendation() async {
    showLoadingContainer();
    await _fetchSelectedUtensil();
    var data = await _recipeUseCase.fetchRecipeRecommendations(
        cancelToken, ingredients, selectedUtensil);
    data.fold((l) {
      hideLoadingContainer();
    }, (result) {
      hideLoadingContainer();
      recipes.clear();
      recipes.addAll(result);
    });
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
