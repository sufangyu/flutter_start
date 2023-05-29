import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:image_pickers/image_pickers.dart';

/// 图片工具类
class ImageUtil {
  /// 截屏图片生成图片流 ByteData
  static Future<ByteData?> capturePngToByteData(
    BuildContext context,
    GlobalKey key,
  ) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary;
      double dpr = MediaQuery.of(context).devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData;
    } catch (err) {
      if (kDebugMode) {
        print("capturePngToByteData error::$err");
      }
    }
    return null;
  }

  /// 保存到相册
  static Future<File?> saveImageToCamera(ByteData byteData) async {
    Uint8List? sourceBytes = byteData.buffer.asUint8List();
    String? path = await ImagePickers.saveByteDataImageToGallery(sourceBytes);
    return path != null ? File(path) : null;
  }
}
