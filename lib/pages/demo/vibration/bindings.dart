import 'package:get/get.dart';

import 'controller.dart';

class VibrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VibrationController>(() => VibrationController());
  }
}
