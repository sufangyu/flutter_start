import 'package:flutter/material.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class MainController extends GetxController {
  MainController();

  /// 生命周期 ========================================
  final state = MainState();

  /// 常用功能
  List<Entry> list = [
    Entry(
      label: "引导页",
      icon: Icons.near_me_rounded,
      path: AppRoutes.GUIDE_SCREEN,
    ),
    Entry(
      label: "网络请求",
      icon: Icons.network_wifi,
      path: AppRoutes.DEMO_REQUEST,
    ),
    Entry(
      label: "图片选择",
      icon: Icons.image_search,
      path: AppRoutes.DEMO_WECHAT_TIMELINE,
    ),
    Entry(
      label: "地图、定位",
      icon: Icons.location_on_outlined,
      path: AppRoutes.MINE_SETTING,
    ),
    Entry(
      label: "相机应用",
      icon: Icons.camera_alt_outlined,
      path: AppRoutes.SCAN,
    ),
    Entry(
      label: "权限申请",
      icon: Icons.security_outlined,
      path: AppRoutes.DEMO_PERMISSION,
    ),
  ];

  /// 常用组件
  List<Entry> widgetList = [
    Entry(
      label: "Sheet",
      icon: Icons.present_to_all,
      path: AppRoutes.DEMO_BOTTOM_SHEET,
    ),
    Entry(
      label: "Dialog",
      icon: Icons.inbox_outlined,
      path: AppRoutes.DEMO_DIALOG,
    ),
    Entry(
      label: "Popover",
      icon: Icons.inbox_outlined,
      path: AppRoutes.DEMO_DIALOG,
    ),
    Entry(
      label: "Popup",
      icon: Icons.inbox_outlined,
      path: AppRoutes.DEMO_DIALOG,
    ),
    Entry(
      label: "水印",
      icon: Icons.wallet,
      path: AppRoutes.DEMO_DIALOG,
    ),
    Entry(
      label: "结果页",
      icon: Icons.wallet,
      path: AppRoutes.DEMO_DIALOG,
    ),
    Entry(
      label: "验证码",
      icon: Icons.spellcheck,
      path: AppRoutes.DEMO_CODE_INPUT_FILED,
    ),
  ];

  /// 生命周期 ========================================
  /// 初始
  @override
  void onInit() {
    super.onInit();
  }

  /// 可 async 拉取数据
  /// 可触发展示交互组件
  /// onInit 之后
  @override
  void onReady() {
    super.onReady();
  }

  /// 关闭页面
  /// 可以缓存数据，关闭各种控制器
  /// dispose 之前
  @override
  void onClose() {
    super.onClose();
  }

  /// 被释放
  @override
  void dispose() {
    super.dispose();
  }
}
