import 'package:get/get.dart';

import 'controller.dart';

class WechatTimelineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WechatTimelineController>(
      () => WechatTimelineController(),
    );
  }
}
