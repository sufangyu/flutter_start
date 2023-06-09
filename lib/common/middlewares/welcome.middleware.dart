import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class WelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  // ignore: overridden_fields
  int? priority = 0;

  WelcomeMiddleware({required this.priority});
  @override
  RouteSettings? redirect(String? route) {
    LoggerUtil.info(
        "APP是否已打开过::${ConfigStore.to.isAlreadyOpen}, 已登录::${UserStore.to().isLogin}");

    if (ConfigStore.to.isAlreadyOpen == true) {
      // 已打开过
      return null;
    }
    // } else if (UserStore.to().isLogin == true) {
    //   // 已登录
    //   return const RouteSettings(name: AppRoutes.APPLICATION);
    // } else {
    //   // 未登录
    //   return const RouteSettings(name: AppRoutes.SIGN_IN);

    // 未打开过
    return const RouteSettings(name: AppRoutes.GUIDE_SCREEN);
  }
}
