import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'controller.dart';

class VibrationPage extends GetView<VibrationController> {
  const VibrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手机振动'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => VibrateUtil.normal(),
            child: const Text("默认振动"),
          ),
          ElevatedButton(
            onPressed: () => VibrateUtil.light(),
            child: const Text("短振动"),
          ),
          ElevatedButton(
            // 使用模式（等待 500 毫秒，振动 1 秒，等待 500 毫秒，振动 2 秒）：
            onPressed: () => VibrateUtil.custom(
              pattern: [500, 1000, 500, 2000],
            ),
            child: const Text("指定振动频率"),
          ),
        ],
      ),
    );
  }
}
