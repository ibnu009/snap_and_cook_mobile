import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../components/loading_container.dart';
import '../../styles/colors.dart';

class BaseViewModel extends GetxController {
  final _loadingContainer = false.obs;

  final cancelToken = CancelToken();
  bool get isLoadingContainer => _loadingContainer.value;

  _updateLoadingContainer(bool isLoading) => _loadingContainer(isLoading);

  showLoadingContainer() => _updateLoadingContainer(true);

  hideLoadingContainer() => _updateLoadingContainer(false);

  void closeLoadingDialog() {
    Get.isDialogOpen ?? false ? Get.back() : null;
  }

  void showLoadingDialog() {
    Get.dialog(
      const LoadingContainer(
          height: 200,
          width: 200,
          bgColor: AppColors.heroWhite, padding: 32),
    );
  }

  @override
  void onClose() {
    cancelToken.cancel();
    super.onClose();
  }
}