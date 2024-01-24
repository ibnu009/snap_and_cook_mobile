import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';
import '../../../components/asset_image_view.dart';
import '../../../styles/values.dart';
import '../../base/base_view.dart';
import '../../../components/appbar/basic_appbar.dart';
import '../../../styles/images.dart';
import '../view_model/utensil_view_model.dart';

class UtensilView extends BaseView<UtensilViewModel> {
  const UtensilView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(appBarTitleText: "", centerTitle: false);
  }

  @override
  Widget body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        const Expanded(
            child: AssetImageView(
          fileName: AppImages.logoFull,
          width: AppValues.logoWidth,
          height: AppValues.logoHeight,
        )),
        Text(controller.version, style: TTCommonsTextStyles.textLg.textMedium()),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
