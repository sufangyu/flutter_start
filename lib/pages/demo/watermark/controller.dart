import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class WatermarkController extends GetxController {
  /// 初始化插件
  final WaterMarkInstance _waterMarkPlugin = WaterMarkInstance();

  void touchEvent() {
    LoggerUtil.debug("触发事件～～～");
  }

  void addWatermark() {
    LoggerUtil.debug("添加水印～～～");
    _waterMarkPlugin.addWatermark(Get.context!, "默认水印");
  }

  void updateWatermark() {
    LoggerUtil.debug("更新水印～～～");
    _waterMarkPlugin.addWatermark(Get.context!, "我是新水印");
  }

  void removeWatermark() {
    LoggerUtil.debug("去除水印～～～");
    _waterMarkPlugin.removeWatermark();
  }
}
