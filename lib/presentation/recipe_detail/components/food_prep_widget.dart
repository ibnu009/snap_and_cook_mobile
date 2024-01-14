import 'package:flutter/material.dart';

import '../../../styles/text_styles/tt_commons_text_styles.dart';

class FoodPrepWidget extends StatelessWidget {
  const FoodPrepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _foodPrepItem('Porsi', '4'),
        _foodPrepItem('Persiapan', '20 menit'),
        _foodPrepItem('Memasak', '30 menit'),
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
