import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../styles/colors.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _circleWidget(),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${ingredient.name} ${ingredient.quantity} ${ingredient.unit}',
            style: TTCommonsTextStyles.textMd.textMedium(),
          ),
        ],
      ),
    );
  }

  Widget _circleWidget() {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.copper,
      ),
    );
  }
}
