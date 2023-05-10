import 'package:get/get.dart';

import 'controller.dart';

class PermissionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermissionController>(() => PermissionController());
  }
}
