import 'package:get/get.dart';

import 'controller.dart';

class BookmarksBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookmarksController>(() => BookmarksController());
  }
}
