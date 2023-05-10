import 'package:get/get.dart';

import 'controller.dart';

class RequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestController>(() => RequestController());
  }
}
