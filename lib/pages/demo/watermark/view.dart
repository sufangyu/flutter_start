import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class WatermarkPage extends GetView<WatermarkController> {
  const WatermarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('水印'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => controller.addWatermark(),
              child: const Text("添加水印"),
            ),
            ElevatedButton(
              onPressed: () => controller.updateWatermark(),
              child: const Text("更新/自定义水印"),
            ),
            ElevatedButton(
              onPressed: controller.removeWatermark,
              child: const Text("去除水印"),
            ),
          ],
        ),
      ),
    );
  }
}
