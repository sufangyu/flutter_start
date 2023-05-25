import 'package:get/get.dart';

import 'controller.dart';

class SkeletonBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkeletonController>(() => SkeletonController());
  }
}
