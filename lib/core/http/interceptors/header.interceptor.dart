import 'package:dio/dio.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:get/get.dart';

/// 请求头自定义拦截器
class HttpHeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Map<String, dynamic>? authorization = getAuthorizationHeader();

    if (authorization != null) {
      options.headers.addAll(authorization);
    }

    return handler.next(options);
  }

  /// 读取本地存储的 token 信息拼装成 header
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    if (Get.isRegistered<UserStore>() && UserStore.to().hasToken == true) {
      headers['Authorization'] = 'Bearer ${UserStore.to().token}';
    }
    return headers;
  }
}
