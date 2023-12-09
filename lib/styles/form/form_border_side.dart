import 'package:flutter/cupertino.dart';

import '../colors.dart';

class FormBorderSide {

  // Border Side
  static BorderSide get sideNormal =>
      const BorderSide(width: 1, color: AppColors.primaryGrey300);
  static BorderSide get sideInactive =>
      const BorderSide(width: 1, color: AppColors.primaryGrey300);
  static BorderSide get sideFocused =>
      const BorderSide(width: 2, color: AppColors.heroBlack);
  static BorderSide get sideError =>
      const BorderSide(width: 2, color: AppColors.semanticRed500);
  static BorderSide get sideInfo =>
      const BorderSide(width: 1, color: AppColors.semanticOrange500);
  static BorderSide get sideSuccess =>
      const BorderSide(width: 1, color: AppColors.semanticGreen500);

}
