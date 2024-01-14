import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/ingredients_item.dart';

class IngredientListWidget extends StatelessWidget {
  const IngredientListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return IngredientItem(ingredient: Ingredient(
          name: "Telur",
          quantity: 1,
          unit: "Butir"
        ));
      },
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
