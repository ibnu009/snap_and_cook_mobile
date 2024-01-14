import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/colors.dart';

class ShimmeringIconSkeleton extends StatelessWidget {
  const ShimmeringIconSkeleton({Key? key, this.size, required this.icon}) : super(key: key);

  final double? size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffcbcbcb),
      highlightColor: const Color(0xffededed),
      enabled: true,
      child: Icon(icon, color: AppColors.primaryLightGrey, size: size ?? 24),
    );
  }
}
