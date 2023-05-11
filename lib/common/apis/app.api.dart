import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/http/index.dart';

/// 系统相关
class AppAPI {
  /// 获取最新版本信息
  static Future<AppUpdateResponseEntity> update({
    required AppUpdateRequestEntity params,
    bool hasLoading = false,
  }) async {
    var response = await HttpUtil().post(
      'https://mock.apifox.cn/m1/1124717-0-default/app/update',
      data: params.toJson(),
      hasLoading: hasLoading,
      loadingText: '检查中...',
    );
    // LoggerUtil.info("data::${response?.code},${response?.data.runtimeType}");
    return AppUpdateResponseEntity.fromJson(response?.data);
  }
}
