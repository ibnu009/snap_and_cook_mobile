import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/presentation/home/binding/home_binding.dart';
import 'package:snap_and_cook_mobile/presentation/home/view/home_view.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/binding/recipe_detection_binding.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/view/recipe_detection_view.dart';

import '../../presentation/recipe_detail/binding/recipe_detail_binding.dart';
import '../../presentation/recipe_detail/view/recipe_detail_view.dart';
import '../../presentation/recipe_detection_result/binding/recipe_detection_result_binding.dart';
import '../../presentation/recipe_detection_result/view/recipe_detection_result_view.dart';
import '../../presentation/splash/binding/splash_binding.dart';
import '../../presentation/splash/view/splash_view.dart';

class MainRoute  {
  static const onboards = "/on-boards-page";
  static const splash = "/";
  static const home = "/home-page";
  static const detection = "/recipe-detection-page";
  static const detectionResult = "/recipe-detection-result-page";
  static const detail = "/recipe-detail-page";

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: detection,
      page: () => const RecipeDetectionView(),
      binding: RecipeDetectionBinding(),
    ),
    GetPage(
      name: detectionResult,
      page: () => const RecipeDetectionResultView(),
      binding: RecipeDetectionResultBinding(),
    ),
    GetPage(
      name: detail,
      page: () => const RecipeDetailView(),
      binding: RecipeDetailBinding(),
    ),
  ];
}
