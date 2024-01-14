import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/components/image/basic_network_image.dart';
import 'package:snap_and_cook_mobile/data/remote/models/recipe_model.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../domain/entities/recipe.dart';

class RecipeFullItem extends StatelessWidget {
  final Recipe recipe;
  final Function(String) onTap;
  const RecipeFullItem({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(recipe.uuid ?? '');
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Text(
                recipe.title ?? 'Masakan',
                style: TTCommonsTextStyles.textLg.textSemiBold(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BasicNetworkImage(
              imageUrl: recipe.image ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT80b6egSM9UngjcWwCu92vjmfRQux7WcZCMQ&usqp=CAU',
              height: 120,
              width: double.infinity,
              boxFit: BoxFit.cover,
            ),
            const SizedBox(
              height: 12,
            ),
            _cookingTimeWidget(),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${recipe.description}',
                style: TTCommonsTextStyles.textSm.textRegular(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cookingTimeWidget(){
    return Row(
      children: [
        const SizedBox(width: 8),
        const Icon(Icons.timer, size: 16),
        const SizedBox(width: 4),
        Text(
          '${recipe.cookTime ?? 0} menit',
          style: TTCommonsTextStyles.textSm.textRegular(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 18),
        const Icon(Icons.soup_kitchen, size: 16),
        const SizedBox(width: 4),
        Text(
          '${recipe.cookTime ?? 0} menit',
          style: TTCommonsTextStyles.textSm.textRegular(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
