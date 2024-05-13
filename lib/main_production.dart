import 'dart:io';

import 'configuration/app_build_config.dart';
import 'data/enums/environment_enum.dart';
import 'init.dart';
import 'main_staging.dart';

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  AppBuildConfig.instantiate(config: BuildConfigEnum.production);
  await init();
}