import 'package:flutter/material.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class PopupController extends GetxController {
  Widget _buildPopupContent() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("这是一段文本"),
        Container(
          color: Colors.grey.withOpacity(0.2),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(color: Colors.red, width: 10, height: 10),
              const OutlinedButton(
                onPressed: PopupWindow.close,
                child: Text("关闭"),
              ),
              Container(color: Colors.red, width: 10, height: 10),
            ],
          ),
        ),
      ],
    );
  }

  void openWithClose() {
    PopupWindow.open(
      Get.context!,
      child: _buildPopupContent(),
      closeOnMaskClick: false,
      title: const Text("我是标题", style: TextStyle(fontSize: 16)),
      round: true,
      closeable: true,
    );
  }

  void openWithRight() {
    PopupWindow.open(
      Get.context!,
      child: _buildPopupContent(),
      position: PopupPosition.right,
    );
  }

  void openWithLeft() {
    PopupWindow.open(
      Get.context!,
      child: _buildPopupContent(),
      position: PopupPosition.left,
    );
  }

  void openWithTop() {
    PopupWindow.open(
      Get.context!,
      child: _buildPopupContent(),
      position: PopupPosition.top,
      round: false,
    );
  }

  void openWithBottom() {
    PopupWindow.open(
      Get.context!,
      position: PopupPosition.bottom,
      child: _buildPopupContent(),
    );
  }

  void openWithRound() {
    PopupWindow.open(
      Get.context!,
      position: PopupPosition.bottom,
      child: _buildPopupContent(),
      round: true,
      title: const Text("我是标题", style: TextStyle(fontSize: 16)),
      onClosed: () {
        LoggerUtil.debug("关闭回调方法");
      },
    );
  }

  ///////////// 关闭按钮位置
  void openWithCloseTopRight() {
    PopupWindow.open(
      Get.context!,
      round: true,
      closeable: true,
      closePosition: PopupClosePosition.topRight,
      child: _buildPopupContent(),
    );
  }

  void openWithCloseTopLeft() {
    PopupWindow.open(
      Get.context!,
      round: true,
      closeable: true,
      closePosition: PopupClosePosition.topLeft,
      child: _buildPopupContent(),
    );
  }

  void openWithCloseBottomRight() {
    PopupWindow.open(
      Get.context!,
      position: PopupPosition.top,
      round: true,
      closeable: true,
      closePosition: PopupClosePosition.bottomRight,
      child: _buildPopupContent(),
    );
  }

  void openWithCloseBottomLeft() {
    PopupWindow.open(
      Get.context!,
      position: PopupPosition.top,
      round: true,
      closeable: true,
      closePosition: PopupClosePosition.bottomLeft,
      child: _buildPopupContent(),
    );
  }

  void openWithCloseMaxHeight() {
    PopupWindow.open(
      Get.context!,
      round: true,
      closeable: true,
      title: const Text("词语解析"),
      // closePosition: PopupClosePosition.topLeft,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "dart extension 的使用场景是无法修改原类的时候，通过扩展的方式来增加原类的方法，也可以增加 getter，setters，and operators"),
            Container(height: 800, color: Colors.grey.withOpacity(0.2)),
            const Text("如果 String 有 parseInt 方法，我们可以这样写"),
          ],
        ),
      ),
    );
  }
}
