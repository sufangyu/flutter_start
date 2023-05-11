import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:get/get.dart';

class SwitchEnvController extends GetxController {
  /// API 环境配置列表
  List<EnvEntity> apiEnvList = HttpConfig.apiEnvConfigs;

  ///
  final Rx<EnvEntity> _curEnvConfig =
      EnvEntity(label: '', code: '', baseUrls: EnvBaseUrlEntity()).obs;
  set curEnvConfig(EnvEntity value) => _curEnvConfig.value = value;
  EnvEntity get curEnvConfig => _curEnvConfig.value;

  /// 切换环境
  Future<void> switchEnv(EnvEntity env) async {
    await ConfigStore.to.setApiEnvCode(env.code);
    getCurEnvApi();
    toastInfo(msg: "${env.label}-${env.code}, 切换成功");
  }

  /// 重置默认环境
  Future<void> resetDefaultEnv() async {
    await ConfigStore.to.resetApiEnvCode();
    getCurEnvApi();
    toastInfo(msg: "重置默认环境成功");
  }

  /// 获取当前环境API信息
  void getCurEnvApi() {
    String curEnvCode = ConfigStore.to.apiEnvCode;
    curEnvConfig =
        HttpConfig.apiEnvConfigs.firstWhere((env) => env.code == curEnvCode);
  }

  @override
  void onInit() {
    super.onInit();

    getCurEnvApi();
  }
}
