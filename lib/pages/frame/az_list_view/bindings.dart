import 'package:get/get.dart';

import 'controller.dart';

class AZListViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AZListViewController>(() => AZListViewController());
  }
}
