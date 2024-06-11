import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/styles/colors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> createUtensilTutorialTargets({
  required GlobalKey keyBottomNavigation1,
}) {
  List<TargetFocus> targets = [];
  targets.add(
    TargetFocus(
      identify: "keyBottomNavigation1",
      keyTarget: keyBottomNavigation1,
      color: Colors.black38,
alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.custom,
          customPosition: CustomTargetContentPosition(
            top: Get.height * 0.25,
            left: 0,
            right: 0,
          ),
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pilih Alat Memasak",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 8,),
                const Text(
                  "Tekan tombol alat memasak yang kamu miliki, dan tekan lagi untuk membatalkan pilihan",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    Container(
                      color: AppColors.copper,
                      height: 22,
                      width: 22,
                    ),
                    const SizedBox(width: 8,),
                    const Expanded(
                      child: Text(
                        "Warna oranye berarti kamu telah memilih dan miliki",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    Container(
                      height: 22,
                      width: 22,
                      color: AppColors.heroWhite,
                    ),
                    const SizedBox(width: 8,),
                    const Expanded(
                      child: Text(
                        "Warna putih berarti tidak kamu pilih",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    ),
  );

  return targets;
}