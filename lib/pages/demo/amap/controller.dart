import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/config/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'index.dart';

class AMapController extends GetxController {
  AMapState state = AMapState();

  /// 实例化
  final AMapFlutterLocation _location = AMapFlutterLocation();

  /// 监听定位
  late final StreamSubscription<Map<String, Object>>? _locationListener;

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

    _listenerLocation();
  }

  @override
  onClose() {
    super.onClose();

    ///移除定位监听
    _locationListener?.cancel();

    ///销毁定位
    _location.destroy();
  }

  /// 获取定位信息
  startLocation() {
    PermissionUtil.checkPermission(
      permissions: [Permission.location],
      onSuccess: () {
        LoggerUtil.debug("获取定位权限成功");
        _setLocationOption();
        _location.startLocation();
      },
    );
  }

  /// 停止定位
  void stopLocation() {
    _location.stopLocation();
  }

  /// 注册定位结果监听
  /// 错误吗对照表：https://lbs.amap.com/api/android-location-sdk/guide/utilities/errorcode
  void _listenerLocation() {
    _locationListener = _location.onLocationChanged().listen((result) {
      LoggerUtil.info("result::$result");
      state.result = AmapEntity(
        latitude: result["latitude"].toString(),
        longitude: result["longitude"].toString(),
        country: result["country"].toString(),
        province: result["province"].toString(),
        city: result["city"].toString(),
        district: result["district"].toString(),
        street: result["street"].toString(),
        adCode: result["adCode"].toString(),
        address: result["address"].toString(),
        cityCode: result["cityCode"].toString(),
      );
    });
  }

  /// 开始定位之前设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _location.setLocationOption(locationOption);
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
