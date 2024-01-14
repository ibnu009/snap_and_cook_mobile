import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/remote/services/recipe_service.dart';
import 'package:snap_and_cook_mobile/utils/extension/dio_extension.dart';
import 'components/app/app.dart';
import 'configuration/app_environtment.dart';
import 'resources/constants/session_constants.dart';
import 'utils/interceptor/authorization_header_interceptor.dart';
import 'utils/session/session.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<Dio>(
    () async => Dio().baseUrl(AppEnvironment.apiUrl).addInterceptor(
        AuthorizationHeaderInterceptor(
            onToken: () async =>
                await Session.get(SessionConstants.token) ?? "")),
  );

  await Get.putAsync(() async => Session());
  await Get.putAsync(() async => RecipeServices(Get.find<Dio>()));
  runApp(const RootRestorationScope(restorationId: 'root', child: App()));
}
