import 'package:get/get.dart';

import 'controller.dart';

class ShareDemoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareDemoController>(() => ShareDemoController());
  }
}
