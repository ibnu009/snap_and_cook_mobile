import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles/tt_commons_text_styles.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryOrange,
      scaffoldBackgroundColor: AppColors.heroWhite,
      dialogBackgroundColor: AppColors.heroWhite,
      dividerColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.heroWhite),
      bottomAppBarTheme:
      const BottomAppBarTheme(color: AppColors.heroWhite, elevation: 4.0),

      // dividerColor: AppColors.basicBlack13,

      // text theme
      textTheme: TextTheme(
          displaySmall: TTCommonsTextStyles.displayXs.textBold()
      ),

      // text button theme
      textButtonTheme: TextButtonThemeData(
        style: const ButtonStyle().copyWith(
          textStyle: MaterialStateProperty.all(
              TTCommonsTextStyles.textSm.textMedium()
          ),
        ),
      ),
    );
  }
}