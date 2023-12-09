import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/values.dart';

class BasicTabView extends StatelessWidget {
  final BuildContext? context;
  final TabController tabController;
  final Decoration tabBarDecoration;
  final TextStyle labelStyle;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color indicatorColor;
  final EdgeInsetsGeometry labelPadding;
  final List<Widget> tabTitles;
  final List<Widget> tabViews;
  final Decoration decoration;

  const BasicTabView({
    Key? key,
    this.context,
    required this.tabController,
    required this.tabTitles,
    required this.tabViews,
    required this.labelStyle,
    this.labelColor = AppColors.heroBlack,
    this.unselectedLabelColor = AppColors.heroBlack,
    this.indicatorColor = AppColors.primaryOrange,
    this.decoration = const BoxDecoration(
        color: AppColors.primaryOrange400,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.primaryOrange200,
          ),
          vertical: BorderSide(
            color: AppColors.primaryOrange200,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGrey100,
            blurRadius: 2,
            spreadRadius: 0.2,
            offset:
                Offset(1, 2), // Shadow position
          ),
        ],),
    this.labelPadding = const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    this.tabBarDecoration = const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.primaryGrey100,
        ),
      ),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          basicTabBarTitle(),
          basicTabView(),
        ],
      ),
    );
  }

  Widget basicTabBarTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 40.h,
      decoration: tabBarDecoration,
      child: SizedBox(
        height: 40.h,
        width: double.infinity,
        child: TabBar(
          indicatorWeight: 2,
          isScrollable: true,
          automaticIndicatorColorAdjustment: true,
          labelStyle: labelStyle,
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          indicatorColor: indicatorColor,
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          labelPadding: labelPadding,
          tabs: tabTitles,
          indicatorSize: TabBarIndicatorSize.label,
          // indicator: decoration,
        ),
      ),
    );
  }

  Widget basicTabView() {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: tabViews,
      ),
    );
  }
}

class BasicTabViewSelection {
  static Widget basicTabViewDefaultSelection({
    required int tabId,
    required int selectedIndex,
    required Widget child,
  }) {
    if (selectedIndex == tabId) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: child,
      );
    }
    return Container(
      child: child,
    );
  }
}
