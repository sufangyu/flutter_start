import 'package:get/get.dart';

import 'controller.dart';

class WechatPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WechatPostController>(
      () => WechatPostController(),
    );
  }
}
