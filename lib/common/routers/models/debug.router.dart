import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/pages/debug/scheme_jump/index.dart';
import 'package:flutter_start/pages/debug/switch_env/index.dart';

import 'package:get/get.dart';

List<GetPage> debugRoutes = [
  GetPage(
    name: AppRoutes.DEBUG_SWITCH_ENV,
    title: '切换环境',
    page: () => const SwitchEnvPage(),
    binding: SwitchEnvBinding(),
  ),
  GetPage(
    name: AppRoutes.DEBUG_SCHEME_JUMP,
    title: 'Scheme URL 页面跳转',
    page: () => const SchemeJumpPage(),
    binding: SchemeJumpBinding(),
  ),
];
