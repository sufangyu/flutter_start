import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AMapViewPage extends GetView<AMapController> {
  const AMapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('高德地图 Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.DEMO_AMAP_LOCATION),
            child: const Text("定位示例"),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.DEMO_AMAP_MAP),
            child: const Text("地图示例"),
          ),
        ],
      ),
    );
  }
}
