import '../data/enums/environment_enum.dart';

class AppBuildConfig {
  late final BuildConfigEnum config;
  bool _lock = false;

  AppBuildConfig._();

  static final AppBuildConfig instance = AppBuildConfig._();

  factory AppBuildConfig.instantiate({required BuildConfigEnum config}) {
    if (instance._lock) return instance;
    instance.config = config;
    instance._lock = true;
    return instance;
  }
}