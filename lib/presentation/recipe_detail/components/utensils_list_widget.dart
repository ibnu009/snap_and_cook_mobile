import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/components/recipe/utensils.dart';

import '../../../data/remote/models/utensil_model.dart';

class UtensilsListWidget extends StatelessWidget {
  final List<String> utensils;
  final List<String> selectedUtensil;

  const UtensilsListWidget(
      {super.key, required this.utensils, required this.selectedUtensil});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return UtensilItem(
            name: utensils[index],
            isSelected: selectedUtensil.contains(utensils[index]),
          );
        },
        itemCount: utensils.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
