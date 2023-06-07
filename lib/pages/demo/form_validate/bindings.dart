import 'package:get/get.dart';

import 'controller.dart';

class FormValidateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormValidateController>(() => FormValidateController());
  }
}
