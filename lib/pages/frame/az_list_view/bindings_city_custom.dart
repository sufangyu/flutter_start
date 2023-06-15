import 'package:get/get.dart';

import 'controller_city_custom.dart';

class AZListViewCityCustomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AZListViewCityCustomController>(
        () => AZListViewCityCustomController());
  }
}
