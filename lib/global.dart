// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'common/controllers/index.dart';
import 'common/store/index.dart';
import 'common/widgets/index.dart';
import 'core/utils/index.dart';

/// 全局处理
class Global {
  /// 初始化、基础配置信息、缓存用户信息
  static Future init() async {
    // app在运行应用程序之前先与Flutter Engine通信, 所以要先将提前初始化全局单例
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    setSystemUi();
    // 示例化 loading
    Loading();

    // APP 生命周期监听
    Get.put(LifeCycleController());
    // 初始化全局缓存
    await Get.putAsync<StorageService>(() => StorageService().init());
    // 全局状态
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());

    // 检查APP更新、是否同意协议
    _checkAppUpdate();
    _checkAgreement();
  }

  /// 设置系统 UI 样式
  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      // 用来设置状态栏顶部和底部样式，默认有 light 和 dark 模式，也可以按照需求自定义样式；
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
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

  /// 检测同意协议状态
  static void _checkAgreement() {
    if (!ConfigStore.to.isAgreementProtocol) {
      Future.delayed(Duration.zero, () async {
        if (Get.context == null) {
          return;
        }

        bool isAgreed = await ProtocolModel().showProtocol(Get.context!);
        if (isAgreed) {
          ConfigStore.to.saveAgreementProtocol();
        } else {
          exit(0);
        }
      });
    }
  }
}
