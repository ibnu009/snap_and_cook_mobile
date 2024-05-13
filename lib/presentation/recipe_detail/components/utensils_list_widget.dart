import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/components/recipe/utensils.dart';

class UtensilsListWidget extends StatelessWidget {
  final List<String> utensils;

  const UtensilsListWidget({super.key, required this.utensils});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return UtensilItem(name: utensils[index], isSelected: false,);
        },
        itemCount: utensils.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
