import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/pages/frame/az_list_view/index.dart';
import 'package:flutter_start/pages/frame/guide/index.dart';
import 'package:flutter_start/pages/frame/sign_in/index.dart';
import 'package:flutter_start/pages/frame/sign_up/index.dart';
import 'package:flutter_start/pages/scan/index.dart';
import 'package:get/get.dart';

List<GetPage> frameworkRoutes = [
  GetPage(
    name: AppRoutes.GUIDE_SCREEN,
    title: "引导页面",
    page: () => const GuidePage(),
    binding: GuideBinding(),
    // middlewares: [],
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
  GetPage(
    name: AppRoutes.AZ_LIST_VIEW,
    title: '索引列表',
    page: () => const AZListViewPage(),
    binding: AZListViewBinding(),
  ),
  GetPage(
    name: AppRoutes.AZ_LIST_VIEW_CITY_CUSTOM,
    title: '索引列表-城市自定义头部',
    page: () => const AZListViewCityCustomPage(),
    binding: AZListViewCityCustomBinding(),
  ),
];
