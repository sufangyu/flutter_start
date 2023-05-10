import 'package:flutter_start/pages/category/index.dart';
import 'package:flutter_start/pages/main/index.dart';
import 'package:flutter_start/pages/mine/account/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
