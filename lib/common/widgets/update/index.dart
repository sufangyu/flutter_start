import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/store/config.store.dart';
import 'package:flutter_start/common/apis/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/dialog.dart';

class AppUpdateUtil {
  late AppUpdateResponseEntity _appUpdateInfo;

  /// 执行 APP 检查逻辑
  Future<void> run({bool? isBackground = true}) async {
    PermissionUtil.checkPermission(
      permissions: [Permission.manageExternalStorage],
      onSuccess: () => _checkAppVersion(isBackground!),
    );
  }

  /// 检查APP版本信息
  /// isBackground: 是否后台执行检测
  Future<void> _checkAppVersion(bool isBackground) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    BaseDeviceInfo baseDeviceInfo = GetPlatform.isIOS
        ? await deviceInfo.iosInfo
        : await deviceInfo.androidInfo;

    AppUpdateRequestEntity requestDeviceInfo = AppUpdateRequestEntity(
      device: GetPlatform.isIOS ? 'ios' : 'android', // 设备: ios android
      channel: ConfigStore.to.channel, // 渠道: 苹果店 华为店 小米店 各种APP平台
      architecture: '', //cpu架构: arm x86
      model: '', // 机型: 小米 HUAWEI OPPO
    );

    _appUpdateInfo = await AppAPI.update(
      params: requestDeviceInfo,
      hasLoading: !isBackground,
    );
    LoggerUtil.info('shopUrl, ${_appUpdateInfo.shopUrl}');
    LoggerUtil.info('fileUrl, ${_appUpdateInfo.fileUrl}');
    LoggerUtil.info('latestVersion, ${_appUpdateInfo.latestVersion}');
    LoggerUtil.info('latestDescription, ${_appUpdateInfo.latestDescription}');

    // if (!isBackground) {
    //   LoadingUtil.dismiss();
    // }

    // 比较版本
    final isNewVersion =
        _appUpdateInfo.latestVersion.compareTo(ConfigStore.to.version) == 1;
    LoggerUtil.info(
        "当前版本(${ConfigStore.to.version}), 最新版本（${_appUpdateInfo.latestVersion}）,是否需要更新($isNewVersion)");

    if (isNewVersion) {
      _showUpdateDialog();
    } else {
      toastInfo(msg: "当前已是最新版");
    }
  }

  /// 显示更新弹窗
  void _showUpdateDialog() {
    PageRoute pageRoute = PageRouteBuilder(
      // 背景透明 方式打开新的页面
      opaque: false,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return AppUpdateDialog(
          isForce: false,
          isBackDismiss: false,
          version: _appUpdateInfo.latestVersion,
          upgradeText: _appUpdateInfo.latestDescription,
          fileUrl: _appUpdateInfo.fileUrl,
          shopUrl: _appUpdateInfo.shopUrl,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      // 动画
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(opacity: animation, child: child);
      },
    );

    Navigator.of(Get.context!).push(pageRoute);
  }
}
