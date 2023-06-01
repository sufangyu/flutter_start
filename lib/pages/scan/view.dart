import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

import 'controller.dart';

class ScanPage extends GetView<ScanPageController> {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF000000),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 扫描区域
          ScanView(
            controller: controller.scanController,
            scanLineColor: const Color(0xFF4759DA),
            onCapture: (data) {
              controller.scanController.pause();
              controller.handleScanResult(data);
            },
          ),
          Positioned(
            left: 45.w,
            top: 200.h,
            child: const Text(
              "请将二维码/条形码置于框内，即可自动识别",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // 手电筒模式
          Positioned(
            left: 80.w,
            bottom: 40.h,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Obx(
                  () => MaterialButton(
                    onPressed: controller.toggleTorchMode,
                    child: Icon(
                      controller.isFlashOn ? Icons.flash_on : Icons.flash_off,
                      size: 32.sp,
                      color: const Color(0xFF4759DA),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            right: 80.w,
            bottom: 40.h,
            child: MaterialButton(
              onPressed: controller.scanPhoto,
              child: Icon(
                Icons.image_outlined,
                size: 32.sp,
                color: const Color(0xFF4759DA),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
