import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/remote/services/recipe_service.dart';
import 'package:snap_and_cook_mobile/utils/extension/dio_extension.dart';
import 'package:snap_and_cook_mobile/utils/interceptor/platform_header_interceptor.dart';

import 'components/app/app.dart';
import 'configuration/app_environtment.dart';
import 'utils/session/session.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnvironment.load();

  await Get.putAsync<Dio>(
    () async => Dio()
        .baseUrl(AppEnvironment.apiUrl)
        .addInterceptor(PlatformHeaderInterceptor()),
  );

  await Get.putAsync(() async => Session());
  await Get.putAsync(() async => RecipeServices(Get.find<Dio>()));
  runApp(const RootRestorationScope(restorationId: 'root', child: App()));
}
