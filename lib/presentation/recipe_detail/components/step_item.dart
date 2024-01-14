import 'package:flutter/material.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles/tt_commons_text_styles.dart';

class StepItem extends StatelessWidget {
  final String step;
  final int index;

  const StepItem({super.key, required this.step, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _stepContainer(),
          const SizedBox(
            width: 12,
          ),
          Text(
            step,
            style: TTCommonsTextStyles.textMd.textMedium(),
          ),
        ],
      ),
    );
  }

  Widget _stepContainer() {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.copper,
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TTCommonsTextStyles.textMd
              .textMedium()
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
