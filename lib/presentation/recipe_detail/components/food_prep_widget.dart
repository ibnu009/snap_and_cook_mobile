import 'package:flutter/material.dart';

import '../../../styles/text_styles/tt_commons_text_styles.dart';

class FoodPrepWidget extends StatelessWidget {
  final int? serving, prepTime, cookTime;
  const FoodPrepWidget({super.key, this.serving, this.prepTime, this.cookTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _foodPrepItem('Porsi', '${serving ?? 0}'),
        _foodPrepItem('Persiapan', '${prepTime ?? 0} menit'),
        _foodPrepItem('Memasak', '${cookTime ?? 0} menit'),
      ],
    );
  }

  Widget _foodPrepItem(String title, String description){
    return Column(
      children: [
        Text(title, style: TTCommonsTextStyles.textLg.textMedium()),
        const SizedBox(height: 8,),
        Text(description, style: TTCommonsTextStyles.textSm.textRegular()),
      ],
    );
  }
}
