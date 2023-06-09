import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class SchemeJumpController extends GetxController {
  SchemeJumpState state = SchemeJumpState();

  /// 生命周期 -------------------------------------------
  @override
  void onInit() {
    super.onInit();

    LoggerUtil.debug("Get.arguments::${Get.arguments}");
    state.schemeUri = Get.arguments?['uri'] ?? '';
    state.schemeUriHost = Get.arguments?['host'] ?? '';
    state.schemeUriQuery = Get.arguments?['query'] ?? '';
  }

  /// 静态数据、普通函数 -----------------------------------
}
