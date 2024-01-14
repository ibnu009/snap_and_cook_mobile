import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/enums/environment_enum.dart';
import '../resources/constants/environtment_constant.dart';
import 'app_build_config.dart';

class AppEnvironment {
  static load() async {
    if (AppBuildConfig.instance.config == BuildConfigEnum.production) {
      await dotenv.load(fileName: "production/.env");
    } else {
      await dotenv.load(fileName: "staging/.env");
    }
  }

  static Map<String, String> get env => dotenv.env;

  static String get apiUrl => dotenv.env[EnvironmentConstant.baseUrl] ?? '';
  static String get imageUrl => dotenv.env[EnvironmentConstant.imageUrl] ?? '';


}

