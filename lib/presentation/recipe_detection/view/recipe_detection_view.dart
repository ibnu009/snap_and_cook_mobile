import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/components/basic_button.dart';
import 'package:snap_and_cook_mobile/styles/colors.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../components/detection_result_widget.dart';
import '../view_model/recipe_detection_view_model.dart';

class RecipeDetectionView extends BaseView<RecipeDetectionViewModel> {
  const RecipeDetectionView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(
      appBarTitleText: "Deteksi Bahan",
      centerTitle: true,
      leadingIconData: Icons.arrow_back,
    );
  }

  @override
  Color backgroundColor() {
    return AppColors.canvas;
  }

  @override
  Widget? bottomSheet() {
    return _detectionResultWidget();
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      if (controller.isShowDetectionResult.value) {
        return _detection(context);
      }

      return _idleDetectionWidget();
    });
  }

  Widget _idleDetectionWidget() {
    /// Rounded corner container
    return Center(
        child: Container(
      width: Get.width * 0.8,
      height: Get.height * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.camera_alt_outlined, size: 50),
          const SizedBox(height: 16),
          Text(
            "Ambil gambar bahan makanan yang kamu miliki, aplikasi akan memberikan rekomendasi resep yang dapat kamu buat.",
            textAlign: TextAlign.center,
            style: TTCommonsTextStyles.textSm.textRegular(),
          ),
          const SizedBox(height: 16),
          BasicButton(
              onPress: controller.pickImage, height: 42, text: "Ambil Gambar")
        ],
      ),
    ));
  }

  Widget _detectionResultWidget() {
    return Obx(() {
      return Visibility(
        visible: controller.isShowDetectionResult.value,
        child: const DetectionResultWidget(),
      );
    });
  }

  Widget _detection(BuildContext context) {
    return Obx(() {
      if (controller.imageBytes.value != null) {
        return SizedBox(
          width: Get.width,
          child: Image.memory(
            controller.imageBytes.value!,
            fit: BoxFit.contain,
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
