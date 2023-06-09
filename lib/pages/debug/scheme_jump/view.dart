import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SchemeJumpPage extends GetView<SchemeJumpController> {
  const SchemeJumpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheme URL 打开APP 信息'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() {
            return Text(
              "uri: ${controller.state.schemeUri}",
              style: TextStyle(fontSize: 16.sp),
            );
          }),
          Divider(height: 24.h),
          Obx(() {
            return Text(
              "host: ${controller.state.schemeUriHost}",
              style: TextStyle(fontSize: 16.sp),
            );
          }),
          Divider(height: 24.h),
          Obx(() {
            return Text(
              "query: ${controller.state.schemeUriQuery}",
              style: TextStyle(fontSize: 16.sp),
            );
          }),
          Divider(height: 24.h),
        ],
      ),
    );
  }
}
