import 'package:get/get.dart';

import 'controller.dart';

class SwitchEnvBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SwitchEnvController>(() => SwitchEnvController());
  }
}
