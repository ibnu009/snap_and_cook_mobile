import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/ingredients_item.dart';

class IngredientListWidget extends StatelessWidget {
  final List<Ingredient> ingredients;
  final List<String> selectedIngredient;

  const IngredientListWidget(
      {super.key, required this.ingredients, required this.selectedIngredient});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return IngredientItem(
          ingredient: ingredients[index],
          isSelected: isSelectedIngredient(index),
        );
      },
      itemCount: ingredients.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  String _toChecker(String data){
    if (data == "daging ayam") return 'ayam';
    if (data == "sayap ayam") return 'ayam';
    if (data == "paha ayam") return 'ayam';
    if (data == "dada ayam") return 'ayam';

    return data;
  }

  bool isSelectedIngredient(int index){
    return selectedIngredient.contains(_toChecker(ingredients[index].name?.toLowerCase() ?? ''));
  }

}
