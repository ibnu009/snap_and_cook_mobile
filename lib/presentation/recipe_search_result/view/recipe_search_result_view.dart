import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../../components/form/search_text_field.dart';
import '../../../styles/colors.dart';
import '../../base/base_view.dart';
import '../components/recipe_result_list.dart';
import '../view_model/recipe_search_result_view_model.dart';

class RecipeSearchResultView
    extends BaseView<RecipeSearchResultViewModel> {
  const RecipeSearchResultView({super.key});

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _recipeResultSearch(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Hasil Pencarian:',
                style: TTCommonsTextStyles.textLg.textMedium()),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: RecipeResultList(),
          ),
        ],
      ),
    );
  }

  Widget _recipeResultSearch(){
    return           Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 16,
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
    );
  }
}
