import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:snap_and_cook_mobile/components/basic_button.dart';
import 'package:snap_and_cook_mobile/components/image/basic_network_image.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/ingredient_list_widget.dart';
import 'package:snap_and_cook_mobile/styles/colors.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../components/food_prep_widget.dart';
import '../components/recipe_detail_divider_widget.dart';
import '../components/step_list_widget.dart';
import '../view_model/recipe_detail_view_model.dart';

class RecipeDetailView extends BaseView<RecipeDetailViewModel> {
  const RecipeDetailView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(
      appBarTitleText: "",
      centerTitle: false,
      leadingIconData: Icons.arrow_back,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Obx(() => Text(controller.recipe.value?.title ?? '',
                  style: TTCommonsTextStyles.textXl.textMedium())),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Obx(
                  () => BasicNetworkImage(
                      imageUrl: controller.recipe.value?.image ?? ''),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Obx(
                () => Text(controller.recipe.value?.description ?? '',
                    style: TTCommonsTextStyles.textMd.textRegular()),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Obx(
              () => FoodPrepWidget(
                cookTime: controller.recipe.value?.cookTime,
                prepTime: controller.recipe.value?.prepTime,
                serving: controller.recipe.value?.servings,
              ),
            ),
            const RecipeDetailDividerWidget(
              title: 'Bahan',
            ),
            Obx(
              () => IngredientListWidget(
                ingredients: controller.recipe.value?.ingredients ?? [],
              ),
            ),
            const RecipeDetailDividerWidget(
              title: 'Alat Memasak',
            ),
            const RecipeDetailDividerWidget(
              title: 'Langkah-langkah',
            ),
            StepListWidget(steps:controller.recipe.value?.instructions ?? [],),
            const SizedBox(
              height: 24,
            ),
            BasicButton(
                onPress: () {},
                bgColor: AppColors.copper,
                text: 'Mulai Memasak'),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
