import 'package:get/get.dart';

import '../../../routes/routes/main_route.dart';
import '../../base/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  String version = "Version 0.0.1-dev";

  @override
  void onReady() {
    super.onReady();
    _startSplash();
  }

  @override
  void onClose() {}

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(MainRoute.detection);
  }
}
