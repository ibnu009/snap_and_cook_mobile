import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> createTargets({
  required GlobalKey keyBottomNavigation1,
  required GlobalKey keyBottomNavigation2,
  required GlobalKey keyBottomNavigation3,
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
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deteksi Resep",
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

  targets.add(
    TargetFocus(
      identify: "keyBottomNavigation3",
      keyTarget: keyBottomNavigation3,
      color: Colors.black38,
      alignSkip: Alignment.topLeft,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pengaturan Alat Memasak Yang Dimiliki",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "Tekan tombol berikut untuk mengatur dan menambahkan alat-alat memasak yang kamu miliki di dapurmu",
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