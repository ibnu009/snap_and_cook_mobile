import 'package:get/get.dart';

import '../view_model/recipe_search_result_view_model.dart';

class RecipeSearchResultBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RecipeSearchResultViewModel>(
      () => RecipeSearchResultViewModel(),
    );
  }
}
