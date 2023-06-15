import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class AZListViewDemoController extends GetxController {
  AZListViewDemoState state = AZListViewDemoState();

  /// 生命周期 -------------------------------------------

  /// 静态数据、普通函数 -----------------------------------

  Future<void> cityList() async {
    var result = await Get.toNamed(AppRoutes.AZ_LIST_VIEW);
    LoggerUtil.debug("城市列表选择结果::$result");

    if (result != null) {
      LoadingUtil.success("城市列表选择结果::$result");
    }
  }

  Future<void> cityListCustom() async {
    var result = await Get.toNamed(AppRoutes.AZ_LIST_VIEW_CITY_CUSTOM);
    LoggerUtil.debug("城市列表选择结果::$result");

    if (result != null) {
      LoadingUtil.success("城市列表选择结果::$result");
    }
  }
}
