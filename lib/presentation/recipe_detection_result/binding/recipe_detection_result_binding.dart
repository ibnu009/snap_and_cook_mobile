import 'package:get/get.dart';

import '../view_model/recipe_detection_result_view_model.dart';

class RecipeDetectionResultBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RecipeDetectionResultViewModel>(
      () => RecipeDetectionResultViewModel(),
    );
  }
}
