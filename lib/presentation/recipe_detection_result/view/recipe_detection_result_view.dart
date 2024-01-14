import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../components/detected_ingredients_list.dart';
import '../components/recipe_result_list.dart';
import '../view_model/recipe_detection_result_view_model.dart';

class RecipeDetectionResultView
    extends BaseView<RecipeDetectionResultViewModel> {
  const RecipeDetectionResultView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(
      appBarTitleText: "Hasil Deteksi",
      centerTitle: false,
      leadingIconData: Icons.arrow_back,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('Bahan yang kamu punya',
                style: TTCommonsTextStyles.textLg.textMedium()),
            const SizedBox(height: 16),
            DetectedIngredientList(
              ingredient: controller.ingredients,
            ),
            const SizedBox(height: 24),
            Text('Rekomendasi Resep',
                style: TTCommonsTextStyles.textLg.textMedium()),
            const SizedBox(height: 16),
            RecipeResultList(),
          ],
        ),
      ),
    );
  }
}
