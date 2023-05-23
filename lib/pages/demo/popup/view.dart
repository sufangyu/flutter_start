import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PopupPage extends GetView<PopupController> {
  const PopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popup 弹窗'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.w),
        // color: Colors.white,
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              onPressed: controller.openWithTop,
              child: const Text("顶部弹出"),
            ),
            ElevatedButton(
              onPressed: controller.openWithBottom,
              child: const Text("底部弹出"),
            ),
            ElevatedButton(
              onPressed: controller.openWithLeft,
              child: const Text("左侧弹出"),
            ),
            ElevatedButton(
              onPressed: controller.openWithRight,
              child: const Text("右侧弹出"),
            ),
            ElevatedButton(
              onPressed: controller.openWithClose,
              child: const Text("显示关闭按钮"),
            ),
          ],
        ),
      ),
    );
  }
}
