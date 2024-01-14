import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String version = "Version 0.0.1-dev";

  TextEditingController searchController = TextEditingController();

  void onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  void navigateToRecipeDetail() {
    Get.toNamed(MainRoute.detail);
  }

  void navigateToRecipeDetection() {
    Get.toNamed(MainRoute.detection);
  }

  @override
  void onClose() {}
}
