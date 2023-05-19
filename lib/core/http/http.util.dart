import 'package:cookie_jar/cookie_jar.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_start/core/http/interceptors/index.dart';
import 'package:flutter_start/core/utils/index.dart';

import 'http.config.dart';
import 'entity/http.entity.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio _dio;
  final CancelToken _cancelToken = CancelToken();
  final CookieJar _cookieJar = CookieJar();

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: HttpConfig.connectTimeout,
      receiveTimeout: HttpConfig.receiveTimeout,
      contentType: HttpConfig.contentType,
      headers: {},

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。`JSON`, `STREAM`, `PLAIN`.
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    /// 添加拦截器
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(HttpHeaderInterceptor());
    _dio.interceptors.add(HttpRequestInterceptor());
    _dio.interceptors.add(HttpErrorResponseInterceptor());
    _dio.interceptors.add(FailResponseInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: false));
      // FIXME: 流、二进制文件会拦截报错保存
      _dio.interceptors.add(DioLogInterceptor());
    }
  }

  /// 取消请求
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消
  static void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  /// 请求函数
  Future<Response?> _request<T>(
    String path, {
    required String method,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Options requestOptions = (options ?? Options()).copyWith(
      method: method,
      extra: {
        'baseUrlCode': baseUrlCode,
        'hasLoading': hasLoading,
        'loadingText': loadingText,
        'hasErrorTips': hasErrorTips,
      },
    );

    try {
      Response response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: requestOptions,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioError catch (err) {
      LoggerUtil.error("dio.request DioError::${err.toString()}");
    } on Exception catch (e) {
      LoggerUtil.error("dio.request Exception::${e.toString()}");
      LoadingUtil.error(e.toString());
    }

    return null;
  }

  /// Get 请求函数
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  /// refresh 是否下拉刷新 默认 false
  /// noCache 是否不缓存 默认 true
  /// list 是否列表 默认 false
  /// cacheKey 缓存key
  /// cacheDisk 是否磁盘缓存
  Future<Response?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
    // bool list = false,
  }) async {
    Response? response = await _request<T>(
      path,
      method: 'GET',
      params: queryParameters ?? {},
      options: options ?? Options(),
      cancelToken: cancelToken,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );
    return response;
    // return BaseResponseEntity.fromJson(response?.data); // 标准解析
  }

  /// Post 请求
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<Response?> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Response? response = await _request<T>(
      path,
      method: 'POST',
      params: queryParameters ?? {},
      data: data,
      options: options ?? Options(),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );

    return response;
  }

  /// Put 请求
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<Response?> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Response? response = await _request<T>(
      path,
      method: 'PUT',
      params: queryParameters ?? {},
      data: data,
      options: options ?? Options(),
      cancelToken: cancelToken,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );
    return response;
  }

  /// Patch 请求
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<Response?> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Response? response = await _request<T>(
      path,
      method: 'PATH',
      params: queryParameters ?? {},
      data: data,
      options: options ?? Options(),
      cancelToken: cancelToken,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );
    return response;
  }

  /// Delete 请求
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<Response?> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Response? response = await _request<T>(
      path,
      method: 'DELETE',
      params: queryParameters ?? {},
      data: data,
      options: options ?? Options(),
      cancelToken: cancelToken,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );
    return response;
  }

  /// Post form 表单提交
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<BaseResponseEntity<T>?> postForm<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    bool hasLoading = true,
    bool hasErrorTips = true,
    BaseUrlCodes baseUrlCode = BaseUrlCodes.base,
    String? loadingText,
  }) async {
    Response? response = await _request(
      path,
      method: 'POST',
      data: FormData.fromMap(data),
      params: queryParameters ?? {},
      // FormData 会自动设置 contentType: "multipart/form-data"
      options: options ?? Options(),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      hasLoading: hasLoading,
      baseUrlCode: baseUrlCode,
      loadingText: loadingText,
    );
    return BaseResponseEntity.fromJson(response?.data);
  }

  /// Download 文件下载
  /// [hasLoading] 是否有 loading. 类型: bool
  /// [hasErrorTips] 是否有错误提示. 类型: bool
  /// [baseUrlCode] baseUrl 标识. 类型: BaseUrlCodes
  /// [loadingText] loading 提示信息. 类型 String
  Future<Response?> download<T>(
    String urlPath,
    dynamic savePath, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String lengthHeader = Headers.contentLengthHeader,
    bool deleteOnError = true,
    bool hasLoading = true,
    bool hasErrorTips = true,
    String loadingText = '下载中...',
  }) async {
    Options requestOptions = (options ?? Options()).copyWith(
      receiveTimeout: 0,
      extra: {
        'hasLoading': hasLoading,
        'loadingText': loadingText,
        'hasErrorTips': hasErrorTips,
      },
    );

    try {
      Response? response = await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters ?? {},
        data: data,
        options: requestOptions,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        cancelToken: cancelToken ?? _cancelToken,
        onReceiveProgress: (int count, int total) {
          if (count >= total) {
            LoadingUtil.dismiss();
          }

          if (onReceiveProgress != null) {
            onReceiveProgress(count, total);
          }
        },
      );
      return response;
    } on DioError catch (err) {
      LoggerUtil.error("dio.download DioError::${err.toString()}");
      if (CancelToken.isCancel(err)) {
        LoadingUtil.info("已取消下载");
      } else {
        LoadingUtil.error(err.message);
      }
    } on Exception catch (e) {
      LoggerUtil.error("dio.download Exception::${e.toString()}");
      // OS Error: Is a directory, errno = 21 = 没有文件名
      LoadingUtil.error(e.toString());
    }
    return null;
  }

  // /// 处理响应体（兼容标准、非标准）
  // BaseResponseEntity<T> _handleResponseResult<T>(Response? response) {
  //   LoggerUtil.debug("BaseResponseEntity T::${T.toString()}");
  //   if (response?.data["success"] != null) {
  //     LoggerUtil.info("标准解析");
  //     return BaseResponseEntity.fromJson(response?.data);
  //   } else {
  //     LoggerUtil.info("非标准解析, 组装成标准解析->response::${response?.data}");
  //     return BaseResponseEntity.fromJson({
  //       'success': true,
  //       'code': 200,
  //       'message': '成功',
  //       'data': OtherResponseEntity.fromJson(response?.data).toJson(),
  //     });
  //   }
  // }

  /// 标准解析响应体
  static BaseResponseEntity getDataFromJson(result) {
    return BaseResponseEntity.fromJson(result);
  }
}
