import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/config/index.dart';
import 'package:flutter_start/core/http/index.dart';

class AMapAPI {
  static String baseurl = 'https://restapi.amap.com';

  /// 周边数据
  /// 错误返回：{"status":"0","info":"INVALID_USER_KEY","infocode":"10001"}
  static Future<List<PoisEntity>> getPois(latitude, longitude) async {
    var response = await HttpUtil().get(
      '$baseurl/v3/place/around?key=${MapConfig.webKey}&location=$latitude,$longitude&keywords=&types=&radius=1000&offset=20&page=1&extensions=base',
      hasLoading: false,
    );
    // LoggerUtil.debug(
    //     "getPois response::${PoisResponseEntity.fromJson(response?.data).pois}");

    // 处理 data 是数组的情况
    return List.from(PoisResponseEntity.fromJson(response?.data).pois ?? []);
    // .map((it) => PoisEntity.fromJson(it))
    // .toList();
  }
}
