import 'package:get/get.dart';

import '../view_model/recipe_detail_view_model.dart';

class RecipeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeDetailViewModel>(
      () => RecipeDetailViewModel(),
    );
  }
}
