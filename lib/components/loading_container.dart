import 'package:flutter/material.dart';

import '../styles/colors.dart';

class LoadingContainer extends StatelessWidget {
  final double? width, height, padding;
  final Color? color, bgColor;
  const LoadingContainer({Key? key, this.width, this.height, this.padding, this.color, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width ?? 100,
            height: height ?? 100,
            padding: EdgeInsets.all(padding ?? 0),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: const Color(0xffFFFFFF), width: 0),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: CircularProgressIndicator(
              color: color ?? AppColors.heroBlack,
            ),
          ),
        ),
      ],
    );
  }
}