import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/components/image/basic_network_image.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../domain/entities/recipe.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final Function(String) onTap;
  const RecipeItem({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    print("IMAGE IS ${recipe.image}");
    return GestureDetector(
      onTap: () {
        onTap(recipe.uuid ?? '');
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: BasicNetworkImage(
                imageUrl: recipe.image ?? '',
                height: 160,
                width: double.infinity,
              ),
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
        ),
      ),
    );
  }
}
