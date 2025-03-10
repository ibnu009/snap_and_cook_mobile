import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../components/dismissable_keyboard.dart';
import '../../components/progress_container.dart';
import '../../styles/colors.dart';
import 'base_view_model.dart';

abstract class BaseView<T extends BaseViewModel> extends GetView<T> {
  const BaseView({super.key});

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return annotatedRegion(context);
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: statusBarColor(),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: pageScaffold(context),
    );
  }

  Widget pageScaffold(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: backgroundColor(),
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        body: pageContent(context),
        bottomNavigationBar: bottomNavigationBar(),
        bottomSheet: bottomSheet(),
        drawer: drawer(),
      ),
    );
  }

  Widget? bottomSheet() {
    return null;
  }

  Color statusBarColor() {
    return AppColors.heroWhite;
  }

  Color backgroundColor() {
    return AppColors.heroWhite;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget pageContent(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Obx(
            () => AnimatedOpacity(
              opacity: controller.isLoadingContainer ? 0 : 1,
              duration: const Duration(milliseconds: 750),
              child: body(context),
            ),
          ),
          Obx(
            () => ProgressContainer(
                isShow: controller.isLoadingContainer, onDismiss: null),
          )
        ],
      ),
    );
  }

  Widget? drawer() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }
}
