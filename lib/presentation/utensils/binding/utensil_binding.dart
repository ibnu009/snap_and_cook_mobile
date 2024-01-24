import 'package:get/get.dart';

import '../view_model/utensil_view_model.dart';

class UtensilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtensilViewModel>(
      () => UtensilViewModel(),
    );
  }
}
