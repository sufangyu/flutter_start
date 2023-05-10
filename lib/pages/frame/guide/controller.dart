import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class GuideController extends GetxController {
  GuideController();

  late final List<String> guideImages;
  var state = GuideState();

  /// 进入主程序
  Future<void> gotoApplication() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAllNamed(AppRoutes.APPLICATION);
  }

  @override
  void onInit() {
    super.onInit();

    guideImages = [
      "assets/images/guide/guide_screen_01.png",
      "assets/images/guide/guide_screen_02.png",
      "assets/images/guide/guide_screen_03.png",
    ];
  }
}
