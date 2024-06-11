import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> createDetectionIdleTutorialTargets({
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
            top: 56,
            left: 0,
            right: 0,
          ),
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ambil Gambar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "Tekan tombol berikut untuk mengambil foto bahan makanan dari kamera ataupun galeri",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                  ),
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