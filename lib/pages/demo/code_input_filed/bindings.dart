import 'package:get/get.dart';

import 'controller.dart';

class CodeInputBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeInputController>(() => CodeInputController());
  }
}
