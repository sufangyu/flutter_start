import 'package:get/get.dart';

import 'controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
