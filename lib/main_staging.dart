import 'dart:io';

import 'configuration/app_build_config.dart';
import 'data/enums/environment_enum.dart';
import 'init.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  AppBuildConfig.instantiate(config: BuildConfigEnum.staging);
  await init();
}



