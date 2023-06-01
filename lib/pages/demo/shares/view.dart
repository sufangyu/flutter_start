import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ShareDemoPage extends GetView<ShareDemoController> {
  const ShareDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分享'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: controller.cardShare,
            child: const Text("卡片分享"),
          ),
        ],
      ),
    );
  }
}
