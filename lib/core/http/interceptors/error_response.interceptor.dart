import 'package:dio/dio.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/core/utils/index.dart';

/// HTTP 错误响应自定义拦截器
class HttpErrorResponseInterceptor extends Interceptor {
  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    LoadingUtil.dismiss();
    ErrorEntity errInfo = createErrorEntity(err);
    onErrorHandler(errInfo);

    return handler.next(err);
  }

  /// 错误处理
  void onErrorHandler(ErrorEntity errInfo) {
    LoggerUtil.error(
        'error.code -> ${errInfo.code}, error.message -> ${errInfo.message}');
    String errMsg = "${errInfo.message}-${errInfo.code}";
    LoadingUtil.error(errMsg);

    switch (errInfo.code) {
      case 401:
        UserStore.to().onLogout();
        break;
      default:
        break;
    }
  }

  // 错误信息
  static ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      // case DioErrorType.connectionTimeout:
      case DioErrorType.connectTimeout:
        return ErrorEntity(code: -1, message: "连接超时");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -1, message: "请求超时");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -1, message: "响应超时");
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: "请求取消");
      // case DioErrorType.badResponse:
      case DioErrorType.response:
      case DioErrorType.other:
        {
          try {
            // LoggerUtil.debug("error.response?.statusCode:: ${error.response?.statusCode}");
            int errCode = error.response?.statusCode ?? -1;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "请求语法错误");
              case 401:
                return ErrorEntity(code: errCode, message: "会话过期"); // 没有权限
              case 403:
                return ErrorEntity(code: errCode, message: "拒绝访问");
              case 404:
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              case 405:
                return ErrorEntity(code: errCode, message: "请求方法未允许");
              case 500:
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              case 501:
                return ErrorEntity(code: errCode, message: "网络未实现");
              case 502:
                return ErrorEntity(code: errCode, message: "网络错误");
              case 503:
                return ErrorEntity(code: errCode, message: "服务不可用");
              case 505:
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              default:
                return ErrorEntity(
                  code: errCode,
                  message: error.response?.statusMessage ?? "未知错误",
                );
            }
          } on Exception catch (_) {
            LoggerUtil.error("DioErrorType.other Exception:$_");
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        return ErrorEntity(code: -1, message: error.message);
    }
  }
}

/// 异常 Entity
class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") {
      return "Exception";
    }
    return "Exception: code $code, $message";
  }
}
