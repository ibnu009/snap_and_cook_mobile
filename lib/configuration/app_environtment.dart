import '../resources/constants/environtment_constant.dart';

class AppEnvironment {
  static Map<String, String> get env => <String, String>{
        EnvironmentConstant.baseUrl: const String.fromEnvironment(
            EnvironmentConstant.baseUrl,
            defaultValue: ""),
      };

  static String get baseUrl => env[EnvironmentConstant.baseUrl] ?? '';
}
