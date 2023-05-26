import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart' hide AMapController;
import 'package:flutter/cupertino.dart';
import 'package:flutter_start/common/apis/index.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/config/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index.dart';

class AMapMapController extends GetxController {
  AMapState state = AMapState();

  /// 实例化
  late AMapFlutterLocation _location = AMapFlutterLocation();

  // /// 地图通信中心
  // late AMapController? mapController;

  //
  // /// 周边数据
  // List poisData = [];
  //
  late String _markerLatitude;
  late String _markerLongitude;
  // 出发地址
  late double? _meLatitude;
  late double? _meLongitude;

  @override
  onInit() {
    super.onInit();

    /// 设置Android和iOS的apikey，
    AMapFlutterLocation.setApiKey(MapConfig.androidKey, MapConfig.iosKey);

    // 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyShow(true, true);
    // 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作,这里传true
    AMapFlutterLocation.updatePrivacyAgree(true);

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      _requestAccuracyAuthorization();
    }

    PermissionUtil.checkPermission(
      permissions: [Permission.location],
      onSuccess: () {
        LoggerUtil.debug("获取定位权限成功");
        startLocation();
      },
    );
  }

  @override
  onClose() {
    super.onClose();

    /// 销毁地图定位
    _location.destroy();
  }

  /// 获取定位信息
  startLocation() {
    _location = AMapFlutterLocation()
      ..setLocationOption(AMapLocationOption())
      ..onLocationChanged().listen((event) {
        LoggerUtil.info('event::$event');

        double? latitude = double.tryParse(event['latitude'].toString());
        double? longitude = double.tryParse(event['longitude'].toString());
        _markerLatitude = latitude.toString();
        _markerLongitude = longitude.toString();
        _meLatitude = latitude;
        _meLongitude = longitude;

        state.hasGetLocation = true;
        state.currentLocation = CameraPosition(
          target: LatLng(latitude!, longitude!),
          zoom: 14,
        );

        // state.result = AmapEntity(
        //   latitude: result["latitude"].toString(),
        //   longitude: result["longitude"].toString(),
        //   country: result["country"].toString(),
        //   province: result["province"].toString(),
        //   city: result["city"].toString(),
        //   district: result["district"].toString(),
        //   street: result["street"].toString(),
        //   adCode: result["adCode"].toString(),
        //   address: result["address"].toString(),
        //   cityCode: result["cityCode"].toString(),
        // );
      })
      ..startLocation();
  }

  /// 停止定位
  void stopLocation() {
    _location.stopLocation();
  }

  void onMapCreatedCallback(AMapController controller) {
    // mapController = controller;
  }

  /// 设置地图类型
  void onSetMapType(MapType type) {
    state.mapType = type;
  }

  /// 获取周边数据
  Future<void> getPoisData() async {
    var list = await AMapAPI.getPois(_markerLatitude, _markerLongitude);
    LoggerUtil.debug("list::$list");
    state.poisData = list;
  }

  /// 兴趣点（可以是一栋房子、一个商铺、一个公厕或一个公交站等）
  void onMapPoiTouched(AMapPoi? poi) {
    if (poi == null) {
      return;
    }
    var poiJson = poi.toJson();
    var latlng = poiJson["latLng"];
    LoggerUtil.debug("onMapPoiTouched::$poi, $latlng");
    _markerLongitude = latlng[0].toString();
    _markerLatitude = latlng[1].toString();

    _addMarker(poi.latLng!);
    getPoisData();
  }

  /// 选择地址显示地图位置
  void onSelectAddressOnMap(PoisEntity item) {
    List locationData = item.location.split(',');
    double selectLatitude = double.parse(locationData[0]);
    double selectLongitude = double.parse(locationData[1]);
    _markerLatitude = selectLatitude.toString();
    _markerLongitude = selectLongitude.toString();

    // 重新获取周边数据
    getPoisData();
    _addMarker(LatLng(selectLongitude, selectLatitude));
    // TODO: 检查是否可以删除
    // _changeCameraPosition(LatLng(selectLongitude, selectLatitude));
  }

  // 打开地图应用（长按）
  void onOpenMapApp(PoisEntity item) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('提示'),
          content: const Text('是否进入高德地图导航'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () => Get.back(),
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () async {
                String title = item.name;
                var locationData = item.location.split(',');
                double l1 = double.parse(locationData[0]);
                double l2 = double.parse(locationData[1]);

                Uri uri = Uri.parse(
                    '${Platform.isAndroid ? 'android' : 'ios'}amap://path?sourceApplication=applicationName&sid=&slat=$_meLatitude&slon=$_meLongitude&sname=&did=&dlat=$l2&dlon=$l1&dname=$title&dev=0&t=0');

                try {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    LoadingUtil.error('无法调起高德地图');
                  }
                } catch (e) {
                  LoadingUtil.error('无法调起高德地图');
                }

                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  /// 添加地图标记
  void _addMarker(LatLng markPosition) {
    _removeAll();

    final Marker marker = Marker(
      position: markPosition,
      // 使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    // 将新的marker添加到map里
    state.markers[marker.id] = marker;
    _changeCameraPosition(markPosition);
  }

  /// 清除marker
  void _removeAll() {
    if (state.markers.isNotEmpty) {
      state.markers.clear();
    }
  }

  /// 改变中心点
  void _changeCameraPosition(LatLng markPosition, {double zoom = 15}) {
    state.mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: markPosition, // 中心点
          zoom: zoom, // 缩放级别
          tilt: 30, // 俯仰角0°~45°（垂直与地图时为0）
          bearing: 0, // 偏航角 0~360° (正北方为0)
        ),
      ),
      animated: true,
    );
  }

  /// 获取iOS native的accuracyAuthorization类型
  Future<void> _requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _location.getSystemAccuracyAuthorization();

    switch (currentAccuracyAuthorization) {
      case AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy:
        LoggerUtil.info("精确定位类型");
        break;
      case AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy:
        LoggerUtil.info("模糊定位类型");
        break;
      case AMapAccuracyAuthorization.AMapAccuracyAuthorizationInvalid:
        LoggerUtil.info("模糊定位类型");
        break;
    }
  }
}
