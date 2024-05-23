import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/components/basic_button.dart';
import 'package:snap_and_cook_mobile/styles/colors.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../../utils/detection/bbox.dart';
import '../../../utils/detection/labels.dart';
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
      final bboxesColors = List<Color>.generate(
        6,
        (_) =>
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      );

      final double displayWidth = MediaQuery.of(context).size.width;

      double resizeFactor = 1;

      if (controller.imageWidth.value != null &&
          controller.imageHeight.value != null) {
        double k1 = displayWidth / controller.imageWidth.value!;
        double k2 =
            controller.maxImageWidgetHeight / controller.imageHeight.value!;
        resizeFactor = min(k1, k2);
      }

      List<Bbox> bboxesWidgets = [];
      for (int i = 0; i < controller.bboxes.length; i++) {
        final box = controller.bboxes[i];
        final boxClass = controller.classes[i];
        print("boxClass ${boxClass}");
        bboxesWidgets.add(
          Bbox(
              box[0] * resizeFactor,
              box[1] * resizeFactor,
              box[2] * resizeFactor,
              box[3] * resizeFactor,
              labels[boxClass],
              controller.scores[i],
              bboxesColors[boxClass]),
        );
      }

      if (controller.imageFile.value != null) {
        return SizedBox(
          height: controller.maxImageWidgetHeight,
          child: Center(
            child: Stack(
              children: [
                if (controller.imageFile.value != null) Image.file(controller.imageFile.value!),
                ...bboxesWidgets,
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
