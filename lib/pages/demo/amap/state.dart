import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:get/get.dart';

class AMapState {
  /////////////// 定位 ///////////////
  late final _result = AmapEntity().obs;
  set result(value) => _result.value = value;
  AmapEntity get result => _result.value;

  /////////////// 地图 ///////////////
  late final _hasGetLocation = false.obs;
  set hasGetLocation(bool value) => _hasGetLocation.value = value;
  bool get hasGetLocation => _hasGetLocation.value;

  /// 相机位置
  late final _currentLocation = const CameraPosition(target: LatLng(0, 0)).obs;
  set currentLocation(value) => _currentLocation.value = value;
  CameraPosition get currentLocation => _currentLocation.value;

  /// 地图类型
  late final _mapType = MapType.normal.obs;
  set mapType(MapType value) => _mapType.value = value;
  MapType get mapType => _mapType.value;

  /// 周边数据 RxList<NewsItem>
  final _poisData = Rx<List<PoisEntity>?>(null);
  set poisData(value) => _poisData.value = value;
  List<PoisEntity> get poisData => _poisData.value ?? [];

  /// 地图标记
  final _markers = <String, Marker>{}.obs;
  set markers(value) => _markers.value = value;
  get markers => _markers;

  /// 地图通信中心
  late AMapController mapController;
}
