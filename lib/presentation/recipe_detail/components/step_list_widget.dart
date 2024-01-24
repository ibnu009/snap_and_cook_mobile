import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/step_item.dart';

class StepListWidget extends StatelessWidget {
  final List<String> steps;
  const StepListWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return StepItem(step: steps[index], index: index);
      },
      itemCount: steps.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
