import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';
import 'package:snap_and_cook_mobile/utils/extension/double_extension.dart';

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
          Expanded(
            child: Text(
              '${ingredient.name} ${_getQuantity()} ${ingredient.unit}',
              style: TTCommonsTextStyles.textMd.textMedium(),
            ),
          ),
        ],
      ),
    );
  }

  String _getQuantity() {
    if (ingredient.quantity == null || ingredient.quantity == 0) {
      return '';
    }

    if (ingredient.quantity! % 1 == 0) {
      return '${ingredient.quantity?.toInt()}';
    } else {
      int wholeNumber = ingredient.quantity!.toInt();
      double decimal = ingredient.quantity! - wholeNumber;
      String fraction = decimal.decimalToFraction();

      if (wholeNumber == 0) return fraction.trim();

      return '$wholeNumber $fraction';
    }
  }

  // String _getQuantity(){
  //   if(ingredient.quantity == null || ingredient.quantity == 0){
  //     return '';
  //   }
  //
  //   return '${ingredient.quantity?.toInt()}';
  // }

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
