import 'package:dio/dio.dart';
import 'package:flutter_start/common/store/config.store.dart';
import 'package:flutter_start/core/utils/index.dart';

import '../entity/http.entity.dart';
import '../http.config.dart';

/// 请求前处理 拦截器
class HttpRequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    requestPathHandler(options);
    loadingHandler(options);

    return handler.next(options);
  }

  /// 请求路径 处理
  void requestPathHandler(RequestOptions options) {
    // 根据不同服务处理不同的 baseUrl
    if (options.path.startsWith('http') || options.path.startsWith('https')) {
      return;
    }

    /// 当前环境标识
    String curEnvCode = ConfigStore.to.apiEnvCode;

    /// 当前请求 baseUrl 标识
    String curBaseUrlCode =
        (options.extra['baseUrlCode'] as BaseUrlCodes).value;

    /// 当前 API 环境配置
    EnvEntity curEnvConfig =
        HttpConfig.apiEnvConfigs.firstWhere((env) => env.code == curEnvCode);
    String currBaseUrl = curEnvConfig.baseUrls.toJson()[curBaseUrlCode];

    /// 当前请求 baseUrl
    options.baseUrl = currBaseUrl;
    LoggerUtil.info(
        "requestPathHandler::curEnvCode->$curEnvCode, baseUrlCode->$curBaseUrlCode, currBaseUrl->$currBaseUrl, uri->${options.uri}");
  }

  /// loading 处理
  void loadingHandler(RequestOptions options) {
    if (options.extra['hasLoading']) {
      String loadingMsg = '';
      switch (options.method.toUpperCase()) {
        case 'GET':
          loadingMsg = '加载中...';
          break;
        case 'POST':
          loadingMsg = '提交中...';
          break;
        case 'DELETE':
          loadingMsg = '删除中...';
          break;
        case 'PATH':
          loadingMsg = '提交中...';
          break;
      }
      Loading.show(options.extra['loadingText'] ?? loadingMsg);
    }
  }
}
