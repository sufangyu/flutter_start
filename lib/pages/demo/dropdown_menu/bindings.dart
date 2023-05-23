import 'package:get/get.dart';

import 'controller.dart';

class DropdownBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropdownController>(() => DropdownController());
  }
}
