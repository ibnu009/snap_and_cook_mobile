import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/components/recipe/recipe_item.dart';

import '../../../domain/entities/recipe.dart';
import '../view_model/home_view_model.dart';

class RecipeRecommendationWidget extends GetView<HomeViewModel> {
  const RecipeRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        primary: false,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            controller.navigateToRecipeDetail();
          },
          child: RecipeItem(
            recipe: Recipe(),
          ),
        ),
      ),
    );
  }

  double aspectRatio() {
    int screenHeight = int.parse(Get.height.toStringAsFixed(0));
    double aspectRatio;
    if (screenHeight > 600 && screenHeight < 700) {
      // 5.2 inch
      aspectRatio = Get.width / (Get.height / 0.93);
    } else if (screenHeight > 700 && screenHeight < 800) {
      // 5.7 inch
      aspectRatio = Get.width / (Get.height / 1.07);
    } else if (screenHeight > 800 && screenHeight < 900) {
      // 6.6 inch
      aspectRatio = Get.width / (Get.height / 1.13);
    } else if (screenHeight > 900) {
      // > 7 inch
      aspectRatio = Get.width / (Get.height / 1.09);
    } else {
      // < 5 inch
      aspectRatio = Get.width / (Get.height / 0.85);
    }
    return aspectRatio;
  }
}
