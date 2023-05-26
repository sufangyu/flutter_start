import 'package:get/get.dart';

import 'controller.dart';
import 'controller_map.dart';

class AMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AMapController>(() => AMapController());
    Get.lazyPut<AMapMapController>(() => AMapMapController());
  }
}
