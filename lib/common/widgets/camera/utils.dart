import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CameraUtils {
  /// 监听处理拍摄结果（成功）
  /// [context] 上下文
  /// [cameraState] 拍摄状态
  /// [captureMode] 拍摄类型
  static listenCameraCaptureResult({
    required BuildContext context,
    required CaptureMode captureMode,
    required CameraState cameraState,
  }) {
    cameraState.captureState$.listen((event) async {
      if (event != null && event.status == MediaCaptureStatus.success) {
        // 1. 获取拍摄的图片资源的存储路径
        String filePath = event.filePath;
        String fileTitle = filePath.split("/").last;
        File file = File(filePath);

        // 2. 转换 AssetEntity. 使用 flutter_wechat_assets_picker 库提供的
        AssetEntity? asset;

        switch (captureMode) {
          case CaptureMode.photo:
            // 压缩图片
            var newFileCompress = await CompressUtil.image(File(filePath));
            if (newFileCompress == null) {
              return;
            }
            File newFile = File(newFileCompress.path);

            // 图片转换 AssetEntity
            asset = await PhotoManager.editor.saveImage(
              newFile.readAsBytesSync(),
              title: fileTitle,
            );
            // 删除压缩的临时文件
            await newFile.delete();
            break;
          case CaptureMode.video:
            // 视频转换 AssetEntity
            asset = await PhotoManager.editor.saveVideo(
              file,
              title: fileTitle,
            );
            break;
          case CaptureMode.preview:
            break;
          case CaptureMode.analysis_only:
            break;
        }

        // 3. 删除拍摄的临时文件
        await file.delete();

        // 4. 退出拍摄页, 返回结果
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop<AssetEntity?>(asset);
      }
    });
  }
}
