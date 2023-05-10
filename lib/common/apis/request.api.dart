import 'package:dio/dio.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:flutter_start/core/utils/index.dart';

class RequestDemoAPI {
  /// get 请求（对象结果）
  static Future<RequestResEntity> getObject({RequestReqEntity? params}) async {
    var response = await HttpUtil().get(
      '/result/obj',
      queryParameters: params?.toJson(),
      // baseUrlCode: BaseUrlCodes.open,
    );

    BaseResponseEntity resultJson = HttpUtil.getDataFromJson(response?.data);
    return RequestResEntity.fromJson(resultJson.data);
  }

  /// get 请求（数组结果）
  static Future<List<RequestResEntity>> getList({
    RequestReqEntity? params,
  }) async {
    var response = await HttpUtil().get(
      '/result/list',
      queryParameters: params?.toJson(),
    );

    BaseResponseEntity resultJson = HttpUtil.getDataFromJson(response?.data);
    // 处理 data 是数组的情况
    return List.from(resultJson.data ?? [])
        .map((it) => RequestResEntity.fromJson(it))
        .toList();
  }

  /// get 请求（http 异常结果
  static Future getException() async {
    return await HttpUtil().get('/exception/500');
  }

  /// get 请求（http 结果失败）
  static Future getResultFail() async {
    return await HttpUtil().get('/result/fail');
  }

  /// post 请求
  static Future<ArticleResEntity> postCreate({
    required ArticleReqEntity data,
  }) async {
    var response = await HttpUtil().post(
      '/create',
      data: data.toJson(),
    );
    BaseResponseEntity resultJson = HttpUtil.getDataFromJson(response?.data);
    ArticleResEntity result = ArticleResEntity.fromJson(resultJson.data);
    LoggerUtil.debug("result::${result.title}");
    return result;
  }

  /// 删除请求
  static Future<BaseResponseEntity> deleteUser({required String id}) async {
    var response = await HttpUtil().delete('/delete');
    return HttpUtil.getDataFromJson(response?.data);
  }

  /// put 请求
  static Future<Response?> put({required String id}) async {
    return await HttpUtil().put('/put');
  }

  /// patch 请求
  static Future<Response?> patch({required String id}) async {
    return await HttpUtil().patch('/put');
  }
}
