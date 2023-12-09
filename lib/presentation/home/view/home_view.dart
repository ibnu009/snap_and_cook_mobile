import 'package:flutter/material.dart';
import 'package:snap_and_cook_mobile/styles/text_styles/tt_commons_text_styles.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../view_model/home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

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
        Text(controller.version, style: TTCommonsTextStyles.textLg.textMedium()),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
