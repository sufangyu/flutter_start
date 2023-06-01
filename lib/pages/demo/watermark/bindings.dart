import 'package:get/get.dart';

import 'controller.dart';

class WatermarkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatermarkController>(() => WatermarkController());
  }
}
