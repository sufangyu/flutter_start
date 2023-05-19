import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  /// 简单文本
  void openSimpleLineText() {
    BottomSheetWidget.show(
      Get.context!,
      const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text("一行文本")),
        ],
      ),
      // bodyColor: Colors.red,
    );
  }

  ///
  void openOverLineText() {
    BottomSheetWidget.show(
      Get.context!,
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("这是第一行"),
          const Text(
              "这是很长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长的一段话"),
          Container(height: 400.h, color: Colors.black12),
          const Text(
              "这是很长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长的一段话"),
          Container(height: 400.h, color: Colors.black12),
          const Text(
              "这是很长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长的一段话"),
          Container(height: 10.h, color: Colors.red),
        ],
      ),
      // bodyColor: Colors.red,
      scrollControlled: true,
    );
  }
}
