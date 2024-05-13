import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../routes/routes/main_route.dart';
import '../../styles/themes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _App createState() => _App();
}

class _App extends State<App> with RestorationMixin {
  final RestorableInt _index = RestorableInt(0);

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {}

    @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) => GetMaterialApp(
        // home: MyApp(),
        initialRoute: MainRoute.splash,
        title: "Snap And Cook",
        initialBinding: null,
        unknownRoute: GetPage(
            name: "/route_not_found", page: () => const Text("not found")),
        getPages: routes,
        theme: AppTheme.mainTheme,
        darkTheme: AppTheme.mainTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  String? get restorationId => 'main_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_index, 'main_index');
  }
}


