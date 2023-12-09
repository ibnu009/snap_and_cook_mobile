import 'package:get/get.dart';

import '../view_model/recipe_detection_view_model.dart';

class RecipeDetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeDetectionViewModel>(
      () => RecipeDetectionViewModel(),
    );
  }
}
