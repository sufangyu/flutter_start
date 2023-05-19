import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';

/// 视频压缩返回类型
class CompressMediaFile {
  final File? thumbnail;
  final MediaInfo? video;

  CompressMediaFile({
    this.thumbnail,
    this.video,
  });
}

/// 压缩工具类
class CompressUtil {
  /// 压缩图片
  static Future<XFile?> image(
    File file, {
    int quality = 80,
    int minWidth = 1920,
    int minHeight = 1080,
  }) async {
    return await FlutterImageCompress.compressAndGetFile(
      file.path,
      '${file.path}_temp.jpg',
      keepExif: true,
      quality: quality,
      // format: CompressFormat.jpeg,
      minHeight: minHeight,
      minWidth: minWidth,
    );
  }

  /// 压缩视频
  static Future<CompressMediaFile> video(
    File file, {
    VideoQuality quality = VideoQuality.Res960x540Quality,
    int frameRate = 25,
  }) async {
    var result = await Future.wait([
      VideoCompress.compressVideo(
        file.path,
        quality: quality,
        deleteOrigin: false, // 默认不要去删除原视频
        includeAudio: true,
        frameRate: frameRate,
      ),
      VideoCompress.getFileThumbnail(
        file.path,
        quality: 80,
        position: -1000,
      ),
    ]);
    return CompressMediaFile(
      video: result.first as MediaInfo,
      thumbnail: result.last as File,
    );
  }

  /// 清理视频压缩缓存
  static Future<bool?> clean() async {
    return await VideoCompress.deleteAllCache();
  }

  /// 取消视频压缩
  static Future<void> cancel() async {
    await VideoCompress.cancelCompression();
  }
}
