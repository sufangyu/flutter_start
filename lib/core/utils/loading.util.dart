import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_start/common/widgets/index.dart';

class LoadingUtil {
  LoadingUtil() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = true
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.custom;
  }

  /// 显示 loading
  static void show([String? text]) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text ?? '加载中...');
  }

  /// 显示 toast
  static void toast(
    String text, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.center,
    EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
  }) {
    EasyLoading.showToast(text, toastPosition: position, maskType: maskType);
  }

  /// 原生 toast
  static void toastNative(
    String msg, {
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    toastInfo(msg: msg, backgroundColor: backgroundColor, textColor: textColor);
  }

  /// 显示 info
  static void info(String text) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.showInfo(text);
  }

  /// 显示 error
  static void error(String text) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.showError(text);
  }

  /// 显示 success
  static void success(String text) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.showSuccess(text);
  }

  /// 关闭 loading
  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}
