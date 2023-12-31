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
      path: AppRoutes.DEMO_AMAP_ENTRY,
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
    Entry(
      label: "系统能力",
      icon: Icons.app_settings_alt_outlined,
      path: AppRoutes.DEMO_SYSTEM_FUNC,
    ),
    Entry(
      label: "表单验证",
      icon: Icons.rule,
      path: AppRoutes.DEMO_FORM_VALIDATE,
    ),
    Entry(
      label: "振动",
      icon: Icons.vibration,
      path: AppRoutes.DEMO_VIBRATION,
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
      label: "Popup",
      icon: Icons.inventory_2_outlined,
      path: AppRoutes.DEMO_POPUP,
    ),
    Entry(
      label: "Dropdown",
      icon: Icons.inbox_outlined,
      path: AppRoutes.DEMO_DROPDOWN_MENU,
    ),
    // Entry(
    //   label: "Popover",
    //   icon: Icons.inbox_outlined,
    //   path: AppRoutes.DEMO_DIALOG,
    // ),

    Entry(
      label: "水印",
      icon: Icons.water,
      path: AppRoutes.DEMO_WATERMARK,
    ),
    Entry(
      label: "图片生成",
      icon: Icons.image_search_sharp,
      path: AppRoutes.DEMO_SHARES,
    ),
    // Entry(
    //   label: "结果页",
    //   icon: Icons.wallet,
    //   path: AppRoutes.DEMO_DIALOG,
    // ),
    Entry(
      label: "验证码",
      icon: Icons.spellcheck,
      path: AppRoutes.DEMO_CODE_INPUT_FILED,
    ),
    Entry(
      label: "骨架屏",
      icon: Icons.ballot_outlined,
      path: AppRoutes.DEMO_SKELETON,
    ),
    Entry(
      label: "日期时间",
      icon: Icons.date_range,
      path: AppRoutes.DEMO_DATE_TIME_PICKER,
    ),
    Entry(
      label: "气泡弹窗",
      icon: Icons.filter_frames_outlined,
      path: AppRoutes.DEMO_POPOVER,
    ),
    Entry(
      label: "索引列表",
      icon: Icons.sort_by_alpha,
      path: AppRoutes.DEMO_AZ_LIST_VIEW,
    ),
    Entry(
      label: "侧滑菜单",
      icon: Icons.menu_open_outlined,
      path: AppRoutes.DEMO_SLIDABLE,
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
