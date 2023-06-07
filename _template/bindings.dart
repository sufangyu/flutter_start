import 'package:get/get.dart';

import 'controller.dart';

class ClassNameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassNameController>(() => ClassNameController());
  }
}
