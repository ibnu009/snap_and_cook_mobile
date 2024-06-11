import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/utensils/utensil_use_case.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../data/remote/models/utensil_model.dart';
import '../../../resources/constants/session_constants.dart';
import '../../../utils/session/session.dart';
import '../../base/base_view_model.dart';
import '../components/tutorial_utensils_items.dart';

class UtensilViewModel extends BaseViewModel {
  final _useCase = UtensilUseCase();

  RxList<Utensil> utensils = RxList();
  final buttonKey = GlobalKey();


  late TutorialCoachMark tutorialCoachMark;
  BuildContext? pageContext;

  @override
  void onInit() {
    super.onInit();
    _fetchUtensils();
    createTutorial();
    showTutorial();
  }

  void getPageContext(BuildContext context){
    pageContext = context;
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: createUtensilTutorialTargets(
        keyBottomNavigation1: buttonKey,),
      colorShadow: Colors.black38,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
        Session.set(SessionConstants.isAlreadyOnBoardingUtensil, "yes");
      },
      onClickTarget: (target) {
      },
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        Session.set(SessionConstants.isAlreadyOnBoardingUtensil, "yes");
        return true;
      },
    );
  }

  Future<void> showTutorial() async {
    Future.delayed(const Duration(seconds: 1));
    String? isOnBoarded = await Session.get(SessionConstants.isAlreadyOnBoardingUtensil);
    if (isOnBoarded != null) {
      return;
    }

    if (pageContext?.mounted ?? false){
      tutorialCoachMark.show(context: pageContext!);
    }
  }


  Future<void> _fetchUtensils() async {
    showLoadingContainer();
    utensils.value = await _useCase.fetchUtensils();
    hideLoadingContainer();
  }

  void onSelectUtensil(Utensil utensil, int index){
    if (utensil.isSelected == null || utensil.isSelected == 0){
      utensil.isSelected = 1;
    } else{
      utensil.isSelected = 0;
    }
    utensils[index] = utensil;
    utensils.refresh();
    _useCase.updateUtensil(utensil);
  }

}
