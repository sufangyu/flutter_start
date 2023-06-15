import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class DemoSlidableController extends GetxController {
  DemoSlidableState state = DemoSlidableState();

  /// 生命周期 -------------------------------------------

  /// 静态数据、普通函数 -----------------------------------

  // 触发事件
  void doNothing(String action, int idx) {
    LoggerUtil.debug('触发事件::$action, $idx');
    LoadingUtil.info('触发事件::$action, $idx');
  }
}
