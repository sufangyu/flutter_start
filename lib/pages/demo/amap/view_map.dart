import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_start/config/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'controller_map.dart';

class AMapMapViewPage extends GetView<AMapMapController> {
  const AMapMapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('高德地图-地图'),
      ),
      body: Obx(
        () => controller.state.hasGetLocation == false
            ? const Center(child: Text("加载中..."))
            : Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMap(),
                  _buildListView(),
                ],
              ),
      ),
      floatingActionButton: _buildActions(),
    );
  }

  /// 地图
  Widget _buildMap() {
    return Container(
      width: double.infinity,
      height: 350,
      color: Colors.black12,
      child: SizedBox(
        child: AMapWidget(
          touchPoiEnabled: true,
          // 隐私政策包含高德 必须填写
          privacyStatement: MapConfig.amapPrivacyStatement,
          apiKey: MapConfig.amapApiKeys,
          // 初始化地图中心店
          initialCameraPosition: controller.state.currentLocation,
          // 定位小蓝点
          myLocationStyleOptions: MyLocationStyleOptions(true),
          // 普通地图normal,卫星地图satellite,夜间视图night,导航视图 navi,公交视图bus,
          mapType: controller.state.mapType,
          // 缩放级别范围
          minMaxZoomPreference: const MinMaxZoomPreference(3, 20),
          markers: Set<Marker>.of(controller.state.markers.values),
          onPoiTouched: controller.onMapPoiTouched,
          // onMapCreated: controller.onMapCreatedCallback,
          onMapCreated: (AMapController mapController) {
            controller.state.mapController = mapController;
          },
        ),
      ),
    );
  }

  /// 周边信息列表
  Widget _buildListView() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              '周边信息',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildPoisList(),
          ElevatedButton(
            onPressed: controller.getPoisData,
            child: const Text('获取周边数据'),
          ),
        ],
      ),
    );
  }

  Widget _buildPoisList() {
    return Column(
      children: controller.state.poisData.map((item) {
        return ListTile(
          title: Text(item.name),
          subtitle: Text(
            '${item.pname}${item.cityname}${item.adname}${item.address}',
          ),
          onTap: () => controller.onSelectAddressOnMap(item),
          onLongPress: () => controller.onOpenMapApp(item),
        );
      }).toList(),
    );
  }

  /// 功能浮动按钮
  Widget _buildActions() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close, //带动画的按钮
      animatedIconTheme: const IconThemeData(size: 22.0),
      // visible: isShow, //是否显示按钮
      closeManually: false, //是否在点击子按钮后关闭展开项
      curve: Curves.bounceIn, //展开动画曲线
      overlayColor: Colors.black, //遮罩层颜色
      overlayOpacity: 0.5, //遮罩层透明度
      onOpen: () => LoggerUtil.info('OPENING DIAL'), //展开回调
      onClose: () => LoggerUtil.info('DIAL CLOSED'), //关闭回调
      tooltip: 'Speed Dial', //长按提示文字
      heroTag: 'speed-dial-hero-tag', //hero标记
      backgroundColor: Colors.blue, //按钮背景色
      foregroundColor: Colors.white, //按钮前景色/文字色
      elevation: 8.0, //阴影
      shape: const CircleBorder(), //shape修饰
      children: [
        SpeedDialChild(
          label: '普通地图',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => controller.onSetMapType(MapType.normal),
        ),
        SpeedDialChild(
          label: '卫星地图',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => controller.onSetMapType(MapType.satellite),
        ),
        SpeedDialChild(
          label: '导航地图',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => controller.onSetMapType(MapType.navi),
        ),
        SpeedDialChild(
          label: '公交地图',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => controller.onSetMapType(MapType.bus),
        ),
        SpeedDialChild(
          label: '黑夜模式',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => controller.onSetMapType(MapType.night),
        ),
      ],
    );
  }
}
