import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AZListViewDemoPage extends GetView<AZListViewDemoController> {
  const AZListViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('索引列表'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: controller.cityList,
            child: const Text("城市列表"),
          ),
          ElevatedButton(
            onPressed: controller.cityListCustom,
            child: const Text("城市列表-自定义头部"),
          ),
        ],
      ),
    );
  }
}
