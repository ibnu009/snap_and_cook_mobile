import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/view_model/recipe_detection_view_model.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

class DetectionItemWidget extends GetView<RecipeDetectionViewModel> {
  final Ingredient ingredient;
  final int index;

  const DetectionItemWidget(
      {super.key, required this.ingredient, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {
            controller.removeIngredient(index);
          },
              splashColor: Colors.transparent,
              icon: const Icon(Icons.close)),
          const SizedBox(
            width: 4,
          ),
          Text(
            ingredient.name ?? '',
            style: TTCommonsTextStyles.textMd.textMedium(),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    controller.incrementIngredientQuantity(index);
                  },
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.add_circle_outline)),
              Text(
                '${ingredient.quantity}',
                style: TTCommonsTextStyles.textMd.textMedium(),
              ),
              IconButton(
                  onPressed: () {
                    controller.decrementIngredientQuantity(index);
                  },
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.remove_circle_outline)),
            ],
          ),
        ],
      ),
    );
  }
}
