import 'package:dio/dio.dart';

import 'entity/http.entity.dart';

class HttpConfig {
  /// 基本 url
  static const String baseUrl = ''; // "http://localhost:3000";

  /// 连接服务器超时时间，单位是秒.（当前值为60秒）
  static const Duration connectTimeout = Duration(seconds: 1 * 60);

  /// 响应流上前后两次接受到数据的间隔，单位为秒（当前值为30秒）
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// 请求传值的内容类型（"application/json; charset=utf-8"）
  static const String contentType = Headers.jsonContentType;

  /// API 环境配置
  static List<EnvEntity> apiEnvConfigs = [
    EnvEntity(
      label: '开发环境',
      code: 'dev',
      baseUrls: EnvBaseUrlEntity(
        base: 'http://10.25.5.151:3000',
        open: 'http://10.25.5.151:3000/open',
      ),
    ),
    EnvEntity(
      label: '测试环境',
      code: 'test',
      baseUrls: EnvBaseUrlEntity(
        base: 'http://localhost:4000',
        open: 'http://localhost:4000/open',
      ),
    ),
    EnvEntity(
      label: '正式环境',
      code: 'prod',
      baseUrls: EnvBaseUrlEntity(
        base: 'http://localhost:5000',
        open: 'http://localhost:5000/open',
      ),
    ),
  ];
}
