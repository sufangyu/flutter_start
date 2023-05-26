import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AMapLocationViewPage extends GetView<AMapController> {
  const AMapLocationViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = controller.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('高德地图-定位'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Obx(() {
              return Column(children: [
                Text('经度:${state.result.latitude}'),
                Text("纬度:${state.result.longitude}"),
                Text('国家：${state.result.country}'),
                Text('省份：${state.result.province}'),
                Text('城市：${state.result.city}'),
                Text('区：${state.result.district}'),
                Text('城市编码：${state.result.cityCode}'),
                Text('街道：${state.result.street}'),
                Text('邮编：${state.result.adCode}'),
                Text('详细地址：${state.result.address}'),
              ]);
            }),
            const Divider(),
            ElevatedButton(
              onPressed: controller.startLocation,
              child: const Text('开始定位'),
            ),
            ElevatedButton(
              onPressed: controller.stopLocation,
              child: const Text('停止定位'),
            ),
          ],
        ),
      ),
    );
  }
}
