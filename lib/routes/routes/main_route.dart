import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/presentation/home/binding/home_binding.dart';
import 'package:snap_and_cook_mobile/presentation/home/view/home_view.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/binding/recipe_detection_binding.dart';
import 'package:snap_and_cook_mobile/presentation/recipe_detection/view/recipe_detection_view.dart';
import '../../presentation/splash/binding/splash_binding.dart';
import '../../presentation/splash/view/splash_view.dart';

class MainRoute  {
  static const onboards = "/on-boards-page";
  static const splash = "/";
  static const home = "/home-page";
  static const detection = "/recipe-detection-page";

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
  ];
}
