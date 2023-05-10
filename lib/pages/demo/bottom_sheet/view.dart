import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class BottomSheetPage extends GetView<BottomSheetController> {
  const BottomSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: controller.openSimpleLineText,
              child: const Text("最小高度"),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: controller.openOverLineText,
              child: const Text("内容益出"),
            ),
          ],
        ),
      ),
    );
  }
}
