import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:snap_and_cook_mobile/components/recipe/utensils.dart';

import '../../../components/appbar/basic_appbar.dart';
import '../../base/base_view.dart';
import '../view_model/utensil_view_model.dart';

class UtensilView extends BaseView<UtensilViewModel> {
  const UtensilView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return BasicAppBar(
        appBarTitleText: "Alat-Alat Memasak",
        onTapBack: () => Get.back(),
        leadingIconData: Icons.arrow_back,
        centerTitle: false);
  }

  @override
  Widget body(BuildContext context) {
    controller.getPageContext(context);
    return Obx(
      () => Stack(
        children: [
          Wrap(
            children: [
              for (int i = 0; i < controller.utensils.length; i++)
                GestureDetector(
                  onTap: () {
                    controller.onSelectUtensil(controller.utensils[i], i);
                  },
                  child: UtensilItem(
                      name: controller.utensils[i].name ?? '',
                      isSelected: controller.utensils[i].isSelected == 1),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              key: controller.buttonKey,
              height: 20,
              width: 60,
            ),
          )
        ],
      ),
    );
  }

  Widget _utensilsWidget() {
    return Wrap(
      children: [
        for (int i = 0; i < controller.utensils.length; i++)
          UtensilItem(
              name: controller.utensils[i].name ?? '',
              isSelected: controller.utensils[i].isSelected == 1)
      ],
    );
  }
}
