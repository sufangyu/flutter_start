import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_start/common/apis/index.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/widgets/toast.widget.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart' hide Response;

class RequestController extends GetxController {
  /// get ============================================
  final _user = RequestResEntity().obs;
  RequestResEntity get user => _user.value;
  set user(value) => _user.value = value;

  /// 文件下载
  String apkUri =
      "https://lf9-apk.ugapk.cn/package/apk/jj_app/2632_64700/jj_app_download_app_normal_v2632_64700_3a55_1685343635.apk";
  late CancelToken _downloadToken;
  final _downloadRatio = 0.0.obs;
  double get downloadRatio => _downloadRatio.value;
  set downloadRatio(value) => _downloadRatio.value = value;

  /// 返回对象
  Future getObject() async {
    var result = await RequestDemoAPI.getObject(
      params: RequestReqEntity(size: 20, page: 1),
    );
    LoggerUtil.info("get result::${result.age}");
    user = result;
  }

  /// 返回 http 异常
  Future getException() async {
    var result = await RequestDemoAPI.getException();
    LoggerUtil.info("get result-500::$result");
    user = result;
  }

  /// 返回 业务 错误
  Future getResultFail() async {
    var result = await RequestDemoAPI.getResultFail();
    LoggerUtil.info("get result-fail::$result");
    user = result;
  }

  /// 返回数组
  final _userList = <RequestResEntity>[].obs;
  List<RequestResEntity> get userList => _userList;
  set userList(value) => _userList.value = value;

  Future getList() async {
    var result = await RequestDemoAPI.getList(
      params: RequestReqEntity(size: 20, page: 1, keyword: "张"),
    );
    _userList.clear();
    _userList.addAll(result);
  }

  /// post 请求
  Future<void> postCreate() async {
    await RequestDemoAPI.postCreate(
      data: ArticleReqEntity(
        title: "title",
        category: "category",
        content: "content",
      ),
    );

    toastInfo(msg: "添加成功");
  }

  Future<void> delete() async {
    var result = await RequestDemoAPI.deleteUser(id: '');
    if (result.success == false) {
      return;
    }

    LoadingUtil.success("删除成功");
  }

  Future<Response?> put() async {
    return await RequestDemoAPI.put(id: '');
  }

  Future<Response?> patch() async {
    return await RequestDemoAPI.patch(id: '');
  }

  /// 图片上传（post 实现）
  Future<void> upload() async {
    // https://juejin.cn/post/7064357526342483981
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf', 'png', 'txt'],
      // allowMultiple: true,
    );

    if (results == null) {
      return;
    }

    LoggerUtil.debug("FilePickerResult::${results.files}");
    var file = results.files.first;

    await BaseAPI.upload(
      filePath: file.path ?? '',
      fileName: file.name,
      onSendProgress: (int count, int total) {
        debugPrint("$count, $total"); // 取精度，如：
        if (count >= total) {
          LoggerUtil.info("上传完成");
        }
      },
    );

    toastInfo(msg: "上传成功");
  }

  /// 文件下载
  void download() {
    _downloadToken = CancelToken();
    BaseAPI.download(
      apkUri,
      cancelToken: _downloadToken,
      onReceiveProgress: (int count, int total) {
        downloadRatio = (count / total);
        if (downloadRatio >= 1.0) {
          LoadingUtil.success("下载完成");
        }
        // print("downloadWithGet::count->$count, total->$total");
      },
    );
  }

  /// 取消下载
  void cancelDownload() {
    if (downloadRatio < 1.0) {
      HttpUtil.cancelRequests(_downloadToken);

      // 延时执行 (FIX 安卓重置进度)
      Future.delayed(const Duration(seconds: 0), () => downloadRatio = 0.0);
    }
  }

  /// 删除文件
  Future<void> deleteFile() async {
    String filePath = await BaseAPI.getSaveFullPath(apkUri);
    File downloadedFile = File(filePath);

    if (downloadedFile.existsSync()) {
      downloadedFile.delete();
      LoadingUtil.success('删除成功');
      downloadRatio = 0.0;
    } else {
      LoadingUtil.error('文件不存在');
    }
  }
}
