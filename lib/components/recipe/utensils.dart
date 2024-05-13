import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../styles/colors.dart';

class UtensilItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  const UtensilItem({super.key, required this.name, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isSelected ? Colors.white : AppColors.copper,
          width: 1.5
        ),
        color: isSelected ? AppColors.copper : Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Text(
          name,
          style: TTCommonsTextStyles.textMd
              .textRegular()
              .copyWith(color: isSelected ? Colors.white : AppColors.copper),
        ),
      ),
    );
  }
}
