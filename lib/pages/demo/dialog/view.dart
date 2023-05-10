import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DialogPage extends GetView<DialogController> {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('弹窗'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => controller.openDialog('center'),
              child: const Text("居中弹窗"),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => controller.openDialog('bottom'),
              child: const Text("底部弹窗"),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: controller.openDialogMaskColor,
              child: const Text("自定义罩层颜色"),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: controller.openDialogActions,
              child: const Text("自定义按钮"),
            ),
          ],
        ),
      ),
    );
  }
}
