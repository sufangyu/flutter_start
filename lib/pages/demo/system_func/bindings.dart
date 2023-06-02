import 'package:get/get.dart';

import 'controller.dart';

class SystemFuncBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemFuncController>(() => SystemFuncController());
  }
}
