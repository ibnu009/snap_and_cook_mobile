import 'package:flutter/material.dart';
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
    return BasicAppBar(appBarTitleText: "", centerTitle: false, leadingIconData: Icons.arrow_back,);
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text('Nasi Goreng Dadakan', style: TTCommonsTextStyles.textXl.textMedium()),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: BasicNetworkImage(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT80b6egSM9UngjcWwCu92vjmfRQux7WcZCMQ&usqp=CAU')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text('Orak arik telur buncis adalah hidangan lezat yang cocok sebagai lauk makan siang atau makan malam.', style: TTCommonsTextStyles.textMd.textRegular()),
            ),
            Divider(
              color: Colors.grey,
            ),
            FoodPrepWidget(),
            RecipeDetailDividerWidget(title: 'Bahan',),
            IngredientListWidget(),
            RecipeDetailDividerWidget(title: 'Alat Memasak',),
            RecipeDetailDividerWidget(title: 'Langkah-langkah',),
            StepListWidget(),
            SizedBox(height: 24,),
            BasicButton(onPress: (){},
                bgColor: AppColors.copper,
                text: 'Mulai Memasak'),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}
