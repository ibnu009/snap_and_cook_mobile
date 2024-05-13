import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/components/basic_button.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/view_model/recipe_detection_view_model.dart';

import '../../../styles/text_styles/tt_commons_text_styles.dart';
import 'detection_item_widget.dart';

class DetectionResultWidget extends GetView<RecipeDetectionViewModel> {
  const DetectionResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      controller: controller.draggableScrollableController,
      minChildSize: 0.1,
      maxChildSize: 0.85,
      builder: (context, controller) {
        return SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Bahan yang terdeteksi:', style: TTCommonsTextStyles.textMd.textBold(),),
                      ),
                      Obx(() => ListView.builder(
                        itemCount: this.controller.detectedIngredients.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Ingredient ingredient =
                          this.controller.detectedIngredients[index];
                          return DetectionItemWidget(
                              index: index, ingredient: ingredient);
                        },
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: BasicButton(
                                onPress: this.controller.pickImage,
                                text: "Foto Lagi",
                                leadingIcon: Icon(Icons.camera_alt, color: Colors.white),
                                isLeading: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: BasicButton(
                                onPress: this.controller.navigateToRecipeDetectionResult,
                                text: "Cari Resep",
                                leadingIcon: const Icon(Icons.search, color: Colors.white),
                                isLeading: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
