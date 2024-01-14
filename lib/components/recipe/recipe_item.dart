import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/components/image/basic_network_image.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../domain/entities/recipe.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicNetworkImage(
          imageUrl: recipe.image ?? 'https://img.freepik.com/free-photo/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese_90220-1063.jpg',
          height: 160,
          width: double.infinity,
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            recipe.title ?? 'Masakan',
            style: TTCommonsTextStyles.textMd.textMedium(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${recipe.cookTime ?? 0} menit',
            style: TTCommonsTextStyles.textSm.textRegular(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),


      ],
    );
  }
}
