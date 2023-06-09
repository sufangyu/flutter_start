import 'package:get/get.dart';

import 'controller.dart';

class SchemeJumpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchemeJumpController>(() => SchemeJumpController());
  }
}
