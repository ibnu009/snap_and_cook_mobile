import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../styles/colors.dart';

class RecipeDetailDividerWidget extends StatelessWidget {
  final String title;
  const RecipeDetailDividerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.primary
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(title, style: TTCommonsTextStyles.textMd.textMedium().copyWith(
            color: Colors.white
          ),),
        ],
      ),
    );
  }
}
