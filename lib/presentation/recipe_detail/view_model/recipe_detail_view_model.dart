import 'package:get/get.dart';

import '../../../data/remote/models/ingredient_model.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/use_case/general/recipe_use_case.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../base/base_view_model.dart';

class RecipeDetailViewModel extends BaseViewModel {
  final _arguments = Get.arguments;
  String get recipeUuid => _arguments[ArgumentConstants.recipeUuid];
  List<String>? selectedUtensil;
  List<Ingredient>? selectedIngredient;

  List<String> selectedIngredientName = [];
  final RecipeUseCase _recipeUseCase = RecipeUseCase();
  final Rxn<Recipe> recipe = Rxn<Recipe>();

  @override
  void onInit() {
    super.onInit();
    _fetchRecipeDetail();
    init();

    selectedIngredient?.forEach((element) {
      selectedIngredientName.add((element.name ?? '').toLowerCase());
    });
  }

  void init() {
    try {
      selectedUtensil = _arguments[ArgumentConstants.selectedUtensil];
      selectedIngredient = _arguments[ArgumentConstants.selectedIngredient];
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchRecipeDetail() async {
    showLoadingContainer();
    var data = await _recipeUseCase.fetchDetailRecipe(cancelToken, recipeUuid);
    data.fold((l){
    }, (result){
      hideLoadingContainer();
      recipe.value = result;
    });
  }

  @override
  void onClose() {}

}
