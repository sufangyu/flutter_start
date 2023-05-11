import 'package:get/get.dart';

import 'controller.dart';

class ScanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanPageController>(() => ScanPageController());
  }
}
