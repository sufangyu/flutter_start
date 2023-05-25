// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_start/common/middlewares/index.dart';
import 'package:flutter_start/pages/application/index.dart';
import 'package:flutter_start/pages/bookmarks/index.dart';
import 'package:flutter_start/pages/category/bindings.dart';
import 'package:flutter_start/pages/category/view.dart';
import 'package:flutter_start/pages/debug/switch_env/index.dart';
import 'package:flutter_start/pages/demo/bottom_sheet/index.dart';
import 'package:flutter_start/pages/demo/code_input_filed/index.dart';
import 'package:flutter_start/pages/demo/dialog/index.dart';
import 'package:flutter_start/pages/demo/dropdown_menu/index.dart';
import 'package:flutter_start/pages/demo/permission/index.dart';
import 'package:flutter_start/pages/demo/popup/index.dart';
import 'package:flutter_start/pages/demo/request/index.dart';
import 'package:flutter_start/pages/demo/skeleton/index.dart';
import 'package:flutter_start/pages/demo/skeleton/view_list.dart';
import 'package:flutter_start/pages/demo/wechat/post/index.dart';
import 'package:flutter_start/pages/demo/wechat/timeline/index.dart';
import 'package:flutter_start/pages/detail/index.dart';
import 'package:flutter_start/pages/frame/guide/index.dart';
import 'package:flutter_start/pages/frame/sign_in/index.dart';
import 'package:flutter_start/pages/frame/sign_up/index.dart';
import 'package:flutter_start/pages/main/index.dart';
import 'package:flutter_start/pages/mine/about/index.dart';
import 'package:flutter_start/pages/mine/account/index.dart';
import 'package:flutter_start/pages/mine/setting/index.dart';
import 'package:flutter_start/pages/scan/index.dart';
import 'package:get/get.dart';

import 'names.dart';
import 'observers.dart';

class AppPages {
  /// 初始化页面
  static const INITIAL = AppRoutes.GUIDE_SCREEN;
  // static const INITIAL = AppRoutes.DEMO_CODE_INPUT_FILED;

  /// 全局路由监听器
  static final RouteObserver<Route> observer = RouteObservers();

  /// 历史记录
  static List<String> history = [];

  /// 404 页面
  static final unknownRoute = GetPage(
    name: AppRoutes.NOT_FOUND,
    page: () => const Text('Not Found!'),
    // page: () => NotfoundView(),
  );

  /// 路由配置
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.GUIDE_SCREEN,
      title: "引导页面",
      page: () => const GuidePage(),
      binding: GuideBinding(),
      middlewares: [
        WelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      title: "登录页",
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      title: "注册页",
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.SCAN,
      title: '扫描',
      page: () => const ScanPage(),
      binding: ScanBinding(),
    ),
    // 需要登录
    GetPage(
      name: AppRoutes.APPLICATION,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ],
    ),
    GetPage(
      name: AppRoutes.MAIN,
      title: '主页',
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL,
      title: '详情',
      page: () => const DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: AppRoutes.CATEGORY,
      title: '分类',
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.BOOKMARKS,
      title: '书签',
      page: () => const BookmarksPage(),
      binding: BookmarksBinding(),
    ),
    GetPage(
      name: AppRoutes.MINE_ACCOUNT,
      title: '我的/帐号',
      page: () => const AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.MINE_ABOUT,
      title: '我的/关于',
      page: () => const AboutPage(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: AppRoutes.MINE_SETTING,
      title: '我的/设置',
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),

    /// DEBUG
    GetPage(
      name: AppRoutes.DEBUG_SWITCH_ENV,
      title: '切换环境',
      page: () => const SwitchEnvPage(),
      binding: SwitchEnvBinding(),
    ),

    //////////////////////// DEMO ////////////////////////
    GetPage(
      name: AppRoutes.DEMO_PERMISSION,
      title: '权限申请',
      page: () => const PermissionPage(),
      binding: PermissionBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_REQUEST,
      title: '网络请求',
      page: () => const RequestPage(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_WECHAT_TIMELINE,
      title: '朋友圈',
      page: () => const WechatTimelinePage(),
      binding: WechatTimelineBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_WECHAT_ASSETS_PICKER,
      title: '发表',
      page: () => const WechatPostPage(),
      binding: WechatPostBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_BOTTOM_SHEET,
      title: 'BottomSheet',
      page: () => const BottomSheetPage(),
      binding: BottomSheetBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_DIALOG,
      title: '弹窗',
      page: () => const DialogPage(),
      binding: DialogBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_POPUP,
      title: 'Popup 弹出层',
      page: () => const PopupPage(),
      binding: PopupBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_DROPDOWN_MENU,
      title: '下拉框',
      page: () => const DropdownPage(),
      binding: DropdownBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_CODE_INPUT_FILED,
      title: '验证码输入框',
      page: () => const CodeInputPage(),
      binding: CodeInputBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_SKELETON,
      title: '骨架屏',
      page: () => const SkeletonPage(),
      binding: SkeletonBinding(),
    ),
    GetPage(
      name: AppRoutes.DEMO_SKELETON_LIST_VIEW,
      title: '骨架屏-listVIew',
      page: () => const SkeletonListViewPage(),
      binding: SkeletonBinding(),
    ),
  ];
}
