import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class ShimmeringCircleSkeleton extends StatelessWidget {
  const ShimmeringCircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: AppColors.primaryLightGrey,
        shape: BoxShape.circle,
      ),
    );
  }
}