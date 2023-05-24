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
                onPressed: null,
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
      // position: PopupPosition.bottom,
      closeOnMaskClick: false,
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
      onClosed: () {
        LoggerUtil.debug("关闭回调方法");
      },
    );
  }
}
