import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/recipe/recipe_full_item.dart';
import '../../../domain/entities/recipe.dart';
import '../view_model/recipe_detection_result_view_model.dart';

class RecipeResultList extends GetView<RecipeDetectionResultViewModel> {
  const RecipeResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemBuilder: (context, index) {
          Recipe recipe = controller.recipes[index];
          return RecipeFullItem(
            recipe: recipe,
            onTap: controller.navigateToRecipeDetail,
          );
        },
        itemCount: controller.recipes.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
