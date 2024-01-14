import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/colors.dart';

class ShimmeringRoundedSkeleton extends StatelessWidget {
  const ShimmeringRoundedSkeleton({Key? key, this.height, this.width, this.radius}) : super(key: key);

  final double? height, width, radius;

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
        decoration:  BoxDecoration(
            color: AppColors.primaryLightGrey,
            borderRadius:
            BorderRadius.all(Radius.circular(radius ?? 16))),
      ),
    );
  }
}