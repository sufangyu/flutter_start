import 'package:get/get.dart';

import 'controller.dart';

class DemoDateTimePickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoDateTimePickerController>(
        () => DemoDateTimePickerController());
  }
}
