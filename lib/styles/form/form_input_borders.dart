import 'package:flutter/material.dart';

import '../colors.dart';
import '../radiuses.dart';
import 'form_border_side.dart';

class FormInputBorders {


  // Outline Input Border
  static OutlineInputBorder get normalBorder => OutlineInputBorder(
    borderRadius: AppBorderRadius.radius4,
    borderSide: FormBorderSide.sideInactive,
  );
  static OutlineInputBorder get focusedBorder => OutlineInputBorder(
    borderRadius: AppBorderRadius.radius4,
    borderSide: FormBorderSide.sideFocused,
  );
  static OutlineInputBorder get errorBorder => OutlineInputBorder(
    borderRadius: AppBorderRadius.radius4,
    borderSide: FormBorderSide.sideError,
  );
  static OutlineInputBorder get disabledBorder => OutlineInputBorder(
    borderRadius: AppBorderRadius.radius4,
    borderSide: FormBorderSide.sideInactive,
  );

  // Underline Input Border
  static UnderlineInputBorder get normalUnderlineBorder => UnderlineInputBorder(
        borderRadius: AppBorderRadius.radius4,
        borderSide: FormBorderSide.sideInactive.copyWith(
          width: 1,
          color: AppColors.heroBlack,
        ),
      );
  static UnderlineInputBorder get focusedUnderlineBorder =>
      UnderlineInputBorder(
        borderRadius: AppBorderRadius.radius4,
        borderSide: FormBorderSide.sideFocused,
      );
  static UnderlineInputBorder get errorUnderlineBorder => UnderlineInputBorder(
        borderRadius: AppBorderRadius.radius4,
        borderSide: FormBorderSide.sideError,
      );
  static UnderlineInputBorder get disabledUnderlineBorder =>
      UnderlineInputBorder(
        borderRadius: AppBorderRadius.radius4,
        borderSide: FormBorderSide.sideInactive,
      );
}
