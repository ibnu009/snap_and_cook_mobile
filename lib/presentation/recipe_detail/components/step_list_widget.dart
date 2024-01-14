import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/ingredients_item.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detail/components/step_item.dart';

class StepListWidget extends StatelessWidget {
  const StepListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return StepItem(step: "Panaskan minyak goreng", index: index);
      },
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
