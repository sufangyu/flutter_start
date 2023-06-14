import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'controller.dart';
import 'widgets/qr_overlay.dart';
import 'widgets/scan_area.widget.dart';

class ScanPage extends GetView<ScanPageController> {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 360,
      height: 600,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Container(color: Colors.white.withOpacity(0.8)),

          // 识别区域
          MobileScanner(
            scanWindow: scanWindow,
            controller: controller.cameraController,
            onDetect: controller.onDetect,
          ),

          // 全屏扫描效果
          const ScanAreaWidget(scanArea: Size(360, 600)),

          // // 扫描框效果
          // QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.3)),

          /// 底部工具栏
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: _buildExtendTool(),
          ),
        ],
      ),
    );
  }

  /// 底部辅助工具
  Widget _buildExtendTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => _buildToolsItem(
            icon: controller.isFlashOn ? Icons.flash_on : Icons.flash_off,
            label: '照亮',
            onTap: controller.toggleTorchMode,
          ),
        ),
        SizedBox(width: 100.w),
        _buildToolsItem(
          icon: Icons.image_outlined,
          label: '相册',
          onTap: controller.scanPhoto,
        ),
      ],
    );
  }

  Widget _buildToolsItem({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            margin: EdgeInsets.only(bottom: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(icon, size: 24.sp, color: Colors.white),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
