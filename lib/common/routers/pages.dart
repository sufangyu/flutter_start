// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_start/common/middlewares/index.dart';
import 'package:flutter_start/pages/application/index.dart';
import 'package:flutter_start/pages/bookmarks/index.dart';
import 'package:flutter_start/pages/category/bindings.dart';
import 'package:flutter_start/pages/category/view.dart';
import 'package:flutter_start/pages/detail/index.dart';
import 'package:flutter_start/pages/main/index.dart';
import 'package:flutter_start/pages/mine/about/index.dart';
import 'package:flutter_start/pages/mine/account/index.dart';
import 'package:flutter_start/pages/mine/setting/index.dart';
import 'package:get/get.dart';

import 'models/index.dart';
import 'names.dart';
import 'observers.dart';

class AppPages {
  /// 初始化页面
  static const INITIAL = AppRoutes.APPLICATION;
  // static const INITIAL = AppRoutes.DEMO_SHARES;

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
    /// framework
    ...frameworkRoutes,

    // 需要登录
    GetPage(
      name: AppRoutes.APPLICATION,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        WelcomeMiddleware(priority: 1),
        // RouteAuthMiddleware(priority: 1),
      ],
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
    ...debugRoutes,

    /// DEMO
    ...demoRoutes,
  ];
}
