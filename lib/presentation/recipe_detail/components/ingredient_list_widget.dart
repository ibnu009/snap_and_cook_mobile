import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/ingredients_item.dart';

class IngredientListWidget extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientListWidget({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return IngredientItem(ingredient: ingredients[index]);
      },
      itemCount: ingredients.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
