import 'package:get/get.dart';

import 'controller.dart';

class DemoSlidableBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoSlidableController>(() => DemoSlidableController());
  }
}
