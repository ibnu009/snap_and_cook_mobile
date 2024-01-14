import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/styles/colors.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

class DetectedIngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const DetectedIngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            width: 1.5,
            color: AppColors.copper),
      ),
      child: Text(
        '${ingredient.name} ${ingredient.quantity} ${ingredient.unit}',
        style: TTCommonsTextStyles.textMd.textMedium().copyWith(
          color: AppColors.copper,
        ),
      ),
    );
  }
}
