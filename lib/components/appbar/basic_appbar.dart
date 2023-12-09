import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../styles/colors.dart';
import '../asset_image_view.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitleText;
  final Color appBarTitleColor;
  final double appBarTitleSize;
  final FontWeight appBarTitleWeight;
  final double appBarHeight;
  final String? appBarSubTitleText;
  final Color appBarSubTitleColor;
  final double appBarSubTitleSize;
  final FontWeight appBarSubTitleWeight;
  final Function? onTapBack;
  final List<Widget>? actions;
  final double appBarElevation;
  final IconData? leadingIconData;
  final String? leadingImage;
  final bool centerTitle;
  final Color backgroundColor;
  final Color leadingIconColor;
  final double leadingHeight;
  final double leadingWeight;

  BasicAppBar({
    Key? key,
    this.appBarTitleText = '',
    this.appBarTitleColor = AppColors.heroBlack,
    this.appBarTitleSize = 18,
    this.appBarTitleWeight = FontWeight.w500,
    this.appBarHeight = 56,
    this.appBarSubTitleColor = AppColors.heroBlack,
    this.appBarSubTitleSize = 18,
    this.appBarSubTitleWeight = FontWeight.w500,
    this.appBarSubTitleText,
    this.onTapBack,
    this.actions,
    this.appBarElevation = 0,
    this.leadingIconData,
    this.leadingImage = '',
    this.centerTitle = false,
    this.backgroundColor = AppColors.semanticGreen300,
    this.leadingIconColor = AppColors.heroBlack,
    this.leadingHeight = 24,
    this.leadingWeight = 24,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      elevation: appBarElevation,
      toolbarHeight: appBarHeight,
      automaticallyImplyLeading: false,
      actions: actions,
      titleSpacing: 0,
      iconTheme: const IconThemeData(
        color: AppColors.primaryGrey,
      ),
      title: Container(
        width: Get.width,
        margin: actions == null
            ? EdgeInsets.only(
          right: 55.sp,
        )
            : EdgeInsets.zero,
        child: Row(
          children: [
            if (leadingIconData == null && leadingImage!.isEmpty)
              SizedBox(width: 16.w),
            _basicAppBarTitle(),
            SizedBox(width: 8.w),
            _basicAppBarSubTitle(),
          ],
        ),
      ),
      leading: _basicAppBarLeadingIcon(),
    );
  }

  Widget? _basicAppBarLeadingIcon() {
    if (leadingIconData != null || leadingImage!.isNotEmpty) {
      return GestureDetector(
        child: AbsorbPointer(
          child: Center(
            child: AssetImageView(
              materialIcon: leadingIconData,
              height:leadingHeight,
              width: leadingWeight,
              color: leadingIconColor,
              fileName: leadingImage!,
            ),
          ),
        ),
        onTap: () {
          if (onTapBack != null) {
            onTapBack?.call();
          } else {
            Get.back();
          }
        },
      );
    }
    return null;
  }

  Widget _basicAppBarTitle() {
    if (appBarTitleText.isNotEmpty) {
      return Text(
        appBarTitleText,
        style: TTCommonsTextStyles.textMd.textMedium().copyWith(
          color: appBarTitleColor,
          fontSize: appBarTitleSize,
          fontWeight: appBarTitleWeight,
        ),
        textAlign: TextAlign.center,
      );
    }
    return const SizedBox();
  }

  Widget _basicAppBarSubTitle() {
    if (appBarSubTitleText != null) {
      return Text(
        appBarSubTitleText!,
        style: TTCommonsTextStyles.textMd.textMedium().copyWith(
          color: appBarSubTitleColor,
          fontSize: appBarSubTitleSize,
          fontWeight: appBarSubTitleWeight,
        ),
        textAlign: TextAlign.center,
      );
    }
    return const SizedBox();
  }
}
