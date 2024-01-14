import 'package:get/get.dart';

import '../../../data/remote/models/ingredient_model.dart';
import '../../../resources/arguments/argument_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class RecipeDetectionResultViewModel extends BaseViewModel {
  final _argument = Get.arguments as Map<String, dynamic>;

  final List<Ingredient> ingredients = [];

  @override
  void onInit() {
    super.onInit();
    ingredients.addAll(_argument[ArgumentConstants.ingredients] as List<Ingredient>);
  }

  void navigateToRecipeDetail(String uuid){
    Get.toNamed(MainRoute.detail, arguments: {
      ArgumentConstants.recipeUuid: uuid
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

}
