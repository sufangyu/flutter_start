import 'package:get/get.dart';

import 'controller.dart';

class GuideBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuideController>(() => GuideController());
  }
}
