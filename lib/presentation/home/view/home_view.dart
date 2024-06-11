import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/form/search_text_field.dart';
import '../../../styles/colors.dart';
import '../../base/base_view.dart';
import '../components/recipe_recommendation_widget.dart';
import '../view_model/home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      key: controller.cameraKey,
      onPressed: () {
        controller.navigateToRecipeDetection();
      },
      backgroundColor: AppColors.copper,
      child: const Icon(Icons.camera_alt),
    );
  }

  @override
  Color statusBarColor() {
    return AppColors.primaryDarker;
  }

  @override
  Widget body(BuildContext context) {
    controller.getPageContext(context);
    return _buildBody();
  }

  Widget _buildBody(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TTCommonsTextStyles.textLg.textRegular().copyWith(
                        color: AppColors.heroWhite,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        key: controller.settingKey,
                        onPressed: controller.navigateToUtensilPage,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        )),
                  ],
                ),
                SearchTextField(
                  key: controller.searchKey,
                  controller: controller.searchController,
                  hintText: 'Cari Resep..',
                  inputType: TextInputType.text,
                  isOptional: true,
                  onSubmitted: controller.onSearchSubmitted,
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Row(
              children: [
                Text("Rekomendasi Resep :",
                    style: TTCommonsTextStyles.textLg.textMedium()),
                const Spacer(),
              ],
            ),
          ),
          const RecipeRecommendationWidget(),
          const SizedBox(height: 64,)
        ],
      ),
    );
  }

  Widget _ingredientsWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          const SizedBox(width: 8),
          _ingredientItem(),
          _ingredientItem(),
          _ingredientItem(),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _ingredientItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text('Data 1'),
        ],
      ),
    );
  }
}
