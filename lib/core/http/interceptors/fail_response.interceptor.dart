import 'package:dio/dio.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/core/http/entity/http.entity.dart';
import 'package:flutter_start/core/utils/index.dart';

/// 业务逻辑自定义拦截器
class FailResponseInterceptor extends Interceptor {
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    ResponseType responseType = response.requestOptions.responseType;
    // 响应类型是流、字节, 直接跳过
    switch (responseType) {
      case ResponseType.json:
      case ResponseType.plain:
        LoadingUtil.dismiss();
        try {
          BaseResponseEntity result =
              BaseResponseEntity.fromJson(response.data);
          if (result.success == false) {
            onBusinessFailHandler(result, response.requestOptions.extra);
          }
        } catch (_) {}
        break;
      case ResponseType.stream:
      case ResponseType.bytes:
        break;
    }

    handler.next(response);
  }

  /// 业务响应失败处理
  void onBusinessFailHandler(
      BaseResponseEntity result, Map<String, dynamic>? extra) {
    LoggerUtil.error(
        'result.code -> ${result.code}, result.message -> ${result.message}');

    if (extra!['hasErrorTips'] == true) {
      LoadingUtil.error(result.message ?? '请求处理失败');
    }

    switch (result.code) {
      case 401:
        UserStore.to().onLogout();
        break;
      default:
        break;
    }
  }
}
