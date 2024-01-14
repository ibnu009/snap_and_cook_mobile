import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection_result/components/detected_ingredient_item.dart';

import '../../../data/remote/models/ingredient_model.dart';

class DetectedIngredientList extends StatelessWidget {
  final List<Ingredient> ingredient;

  const DetectedIngredientList({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return DetectedIngredientItem(ingredient: ingredient[index]);
          },
          scrollDirection: Axis.horizontal,
          itemCount: ingredient.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics()),
    );
  }
}
