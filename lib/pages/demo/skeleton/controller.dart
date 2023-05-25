import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class SkeletonController extends GetxController {
  SkeletonState state = SkeletonState();

  /// 示例 1
  void setDefaultFlag(bool val) {
    LoggerUtil.debug("setDefaultFlag::$val");
    state.defaultFlag = val;
  }
}
