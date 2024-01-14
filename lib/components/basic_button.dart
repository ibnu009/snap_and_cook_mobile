import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/text_styles/tt_commons_text_styles.dart';

class BasicButton extends StatelessWidget {
  final BuildContext? context;
  final Function onPress;
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final bool isTransparent;
  final bool isBorder;
  final bool isLeading;
  final double borderRadius;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  final Widget? leadingIcon;
  final double sizeText;
  final FontWeight fontWeight;
  final Color disableColor;
  final Color loadingColor;
  final Key? viewKey;

  const BasicButton({
    Key? key,
    this.context,
    required this.onPress,
    required this.text,
    this.isEnabled = true,
    this.isLoading = false,
    this.isTransparent = false,
    this.isBorder = false,
    this.isLeading = false,
    this.borderRadius = 14,
    this.bgColor = AppColors.primary,
    this.textColor = AppColors.heroWhite,
    this.borderColor = AppColors.primary,
    this.height = 42,
    this.sizeText = 16,
    this.leadingIcon,
    this.fontWeight = FontWeight.w500,
    this.disableColor = AppColors.primaryGrey100,
    this.loadingColor = AppColors.heroWhite, this.viewKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: IgnorePointer(
        ignoring: !isEnabled,
        child: TextButton(
          key: viewKey,
          onPressed: () {
            if (isEnabled) onPress.call();
          },
          style: buttonStyle(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                basicButtonLeading(),
                Expanded(child: basicButtonText()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget basicButtonLeading() {
    if (isLeading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leadingIcon ?? const SizedBox(),
        ],
      );
    }
    return const SizedBox();
  }

  Widget basicButtonText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
      style: TTCommonsTextStyles.textSm.textMedium().copyWith(
        color: isEnabled ? AppColors.heroWhite : AppColors.primaryGrey200,
        fontSize: sizeText.sp,
        fontWeight: fontWeight,
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return const ButtonStyle().copyWith(
      backgroundColor: buttonStyleBackgroundColor(),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          side: buttonStyleBorderSide(),
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius,
            ),
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color?> buttonStyleBackgroundColor() {
    if (isTransparent) {
      return MaterialStateProperty.all(Colors.transparent);
    }
    return MaterialStateProperty.all(isEnabled ? bgColor : disableColor);
  }

  BorderSide buttonStyleBorderSide() {
    if (isBorder) {
      return BorderSide(
        width: 1.w,
        color: borderColor,
      );
    }
    return BorderSide(
      width: 0.w,
      color: Colors.transparent,
    );
  }
}
