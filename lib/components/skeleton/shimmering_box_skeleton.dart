import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/colors.dart';

class ShimmeringBoxSkeleton extends StatelessWidget {
  const ShimmeringBoxSkeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffcbcbcb),
      highlightColor: const Color(0xffededed),
      enabled: true,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: AppColors.primaryLightGrey),
      ),
    );
  }
}
