import 'package:get/get.dart';

import 'controller.dart';

class BottomSheetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomSheetController>(() => BottomSheetController());
  }
}
