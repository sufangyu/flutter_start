import 'package:get/get.dart';

import 'controller.dart';

class AZListViewDemoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AZListViewDemoController>(() => AZListViewDemoController());
  }
}
