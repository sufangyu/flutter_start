import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  /// 应用程序已销毁
  @override
  void onDetached() {
    LoggerUtil.debug("LifeCycleController onDetached=====================");
  }

  /// 应用程序处于非活动状态（任务列表运行）
  @override
  void onInactive() {
    LoggerUtil.debug("LifeCycleController onInactive=====================");
  }

  /// 应用程序在后台运行
  @override
  void onPaused() {
    LoggerUtil.debug("LifeCycleController onPaused=====================");
  }

  /// 应用程序正在前台运行
  @override
  Future<void> onResumed() async {
    LoggerUtil.debug("LifeCycleController onResumed=====================");
    _checkAppUpdate();
  }

  /// 检查更新
  static Future<void> _checkAppUpdate() async {
    if (!ConfigStore.to.isRelease) {
      return;
    }
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUpdateUtil().run();
    });
  }
}
