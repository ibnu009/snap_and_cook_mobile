import 'package:get/get.dart';

import '../../../resources/constants/session_constants.dart';
import '../../../routes/routes/main_route.dart';
import '../../../utils/session/session.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String version = "Version 0.0.1-dev";

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
