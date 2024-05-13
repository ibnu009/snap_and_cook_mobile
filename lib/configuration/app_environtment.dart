
import '../resources/constants/environtment_constant.dart';

class AppEnvironment {

  static Map<String, String> get env => <String, String>{
    EnvironmentConstant.baseUrl: const String.fromEnvironment(
        EnvironmentConstant.baseUrl,
        defaultValue: ""),
    EnvironmentConstant.imageUrl: const String.fromEnvironment(
        EnvironmentConstant.imageUrl,
        defaultValue: ""),
  };

  static String get apiUrl => env[EnvironmentConstant.baseUrl] ?? '';
  static String get imageUrl => env[EnvironmentConstant.imageUrl] ?? '';
}

