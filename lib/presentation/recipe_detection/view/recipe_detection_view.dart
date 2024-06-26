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
    controller.getPageContext(context);
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
              key: controller.buttonKey,
              onPress: controller.pickImage,
              height: 42,
              text: "Ambil Gambar")
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
      final bboxesColors = [
        Colors.green,
        Colors.blue,
        Colors.redAccent,
        Colors.purpleAccent,
        Colors.amberAccent,
        Colors.tealAccent,
        Colors.tealAccent,
        Colors.tealAccent,
        Colors.tealAccent,
      ];

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
      for (int i = 0; i < controller.remoteDetectionResult.length; i++) {

        final detection = controller.remoteDetectionResult[i];
        String boxClass = detection.name;
        if (boxClass.contains("Tidak Layak")){
          boxClass = "Bahan Tidak Layak";
        }
        final boxId = detection.datumClass;

        final xcenter = detection.xcenter * controller.imageWidth.value!;
        final ycenter = detection.ycenter * controller.imageHeight.value!;
        final width = detection.width * controller.imageWidth.value!;
        final height = detection.height * controller.imageHeight.value!;

        final left = (xcenter - width / 2) * resizeFactor;
        final top = (ycenter - height / 2) * resizeFactor;
        final right = (xcenter + width / 2) * resizeFactor;
        final bottom = (ycenter + height / 2) * resizeFactor;

        bboxesWidgets.add(
          Bbox(
            left,
            top,
            right,
            bottom,
            boxClass,
            detection.confidence,
            bboxesColors[boxId],
          ),
        );
      }

      if (controller.imageFile.value != null) {
        return SizedBox(
          height: controller.maxImageWidgetHeight,
          child: Center(
            child: Stack(
              children: [
                Image.file(controller.imageFile.value!),
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
