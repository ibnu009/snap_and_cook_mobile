import 'configuration/app_build_config.dart';
import 'data/enums/environment_enum.dart';
import 'init.dart';

void main() async{
  AppBuildConfig.instantiate(config: BuildConfigEnum.production);
  await init();
}