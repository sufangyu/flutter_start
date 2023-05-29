import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'widgets/card_share.widget.dart';

class ShareDemoController extends GetxController {
  void cardShare() {
    LoadingUtil.show();

    // 延时执行返回. 模拟请求数据后才显示
    Future.delayed(const Duration(seconds: 1), () {
      LoadingUtil.dismiss();
      CardShare.show(Get.context!);
    });
  }
}
