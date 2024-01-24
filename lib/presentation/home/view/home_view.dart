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
                SizedBox(
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        )),
                  ],
                ),
                SearchTextField(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Text("Cari berdasarkan 1 bahan",
                style: TTCommonsTextStyles.textLg.textMedium()),
          ),
          _ingredientsWidget(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Row(
              children: [
                Text("Rekomendasi",
                    style: TTCommonsTextStyles.textLg.textMedium()),
                const Spacer(),
                Text("Lihat Semua",
                    style: TTCommonsTextStyles.textSm.textRegular()),
              ],
            ),
          ),
          RecipeRecommendationWidget(),
          SizedBox(height: 64,)
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
          Text('Data 1'),
        ],
      ),
    );
  }
}
