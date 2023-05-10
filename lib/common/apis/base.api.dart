import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:dio/dio.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:path_provider/path_provider.dart';

class BaseAPI {
  /// 图片上传
  static Future<dynamic> upload({
    required String filePath,
    required String fileName,
    ProgressCallback? onSendProgress,
  }) async {
    LoggerUtil.debug("upload::filePath->$filePath, fileName->$fileName");
    Map<String, MultipartFile> uploadFormData = {
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
    };

    return await HttpUtil().postForm(
      '/upload',
      data: uploadFormData,
      baseUrlCode: BaseUrlCodes.open,
      loadingText: '上传中...',
      onSendProgress: onSendProgress,
    );
  }

  /// 文件下载
  static Future<dynamic> download(
    String urlPath, {
    String? savePath,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  }) async {
    dynamic saveFullPath = savePath;
    if (saveFullPath == null || saveFullPath == '') {
      saveFullPath = await getSaveFullPath(urlPath);
    }

    LoggerUtil.info("savePath::$saveFullPath");

    return await HttpUtil().download(
      urlPath,
      saveFullPath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      // String lengthHeader = Headers.contentLengthHeader,
      data: data,
      options: options,
      hasLoading: false,
    );
  }

  /// 获取 保存
  static Future<String> getSaveFullPath(String path) async {
    String saveDir = await getLocalPath();
    String filename = getFilename(path);
    return "$saveDir/$filename";
  }

  /// 获取文件名
  static String getFilename(String path) {
    return p.basename(path);
  }

  /// 获取存储路径
  // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
  // 如果是android，使用getExternalStorageDirectory
  // 如果是iOS，使用getApplicationSupportDirectory
  static Future<String> getLocalPath() async {
    final Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    if (directory == null) {
      throw "Could not get directory";
    } else {
      return directory.path;
    }
  }
}
