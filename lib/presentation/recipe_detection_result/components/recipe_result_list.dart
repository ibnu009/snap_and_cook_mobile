import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/recipe/recipe_full_item.dart';
import '../../../domain/entities/recipe.dart';
import '../view_model/recipe_detection_result_view_model.dart';

class RecipeResultList extends GetView<RecipeDetectionResultViewModel> {
  const RecipeResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return RecipeFullItem(
            recipe: Recipe(
              title: 'Masakan',
              cookTime: 0,
              image:
                  'https://img.freepik.com/free-photo/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese_90220-1063.jpg',
            ),
            onTap: controller.navigateToRecipeDetail,
          );
        },
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics());
  }
}
