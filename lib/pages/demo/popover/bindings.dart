import 'package:get/get.dart';

import 'controller.dart';

class DemoPopoverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoPopoverController>(() => DemoPopoverController());
  }
}
