import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_container.dart';

class ProgressContainer extends StatelessWidget {
  final void Function()? onDismiss;
  final bool isShow;

  const ProgressContainer({
    Key? key,
    this.onDismiss,
    this.isShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isShow ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: isShow
          ? GestureDetector(
              onTap: onDismiss,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.white.withOpacity(0.7),
                  child: const LoadingContainer(),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}