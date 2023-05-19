import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'widgets/take_photo.dart';
import 'widgets/take_video.dart';

class CameraPage extends StatelessWidget {
  /// 拍照、拍视频
  final CaptureMode captureMode;

  /// 视频最大时长 秒
  final Duration? maxVideoDuration;

  const CameraPage({
    Key? key,
    required this.captureMode,
    this.maxVideoDuration,
  }) : super(key: key);

  // 生成文件路径
  Future<String> _buildFilePath() async {
    // final extDir = await getApplicationDocumentsDirectory();
    final extDir = await getTemporaryDirectory();
    // 扩展名
    final extentName = captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
    return '${extDir.path}/${const Uuid().v4()}.$extentName';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CameraAwesomeBuilder.custom(
        saveConfig: captureMode == CaptureMode.photo
            ? SaveConfig.photo(pathBuilder: _buildFilePath)
            : SaveConfig.video(pathBuilder: _buildFilePath),
        // // 生成规则
        // imageAnalysisConfig: AnalysisConfig(
        //   androidOptions: AndroidAnalysisOptions(
        //     outputFormat: InputAnalysisImageFormat.jpeg, // 图像格式
        //   ),
        // ),
        // // 经纬度, 墙
        // exifPreferences: ExifPreferences(
        //   saveGPSLocation: true,
        // ),
        builder: (cameraState, previewSize, previewRect) {
          // create your interface here
          return cameraState.when(
            // 拍照
            onPhotoMode: (state) => TakePhotoPage(cameraState: cameraState),
            // 拍视频
            onVideoMode: (state) => TakeVideoPage(
              cameraState: cameraState,
              maxVideoDuration: maxVideoDuration,
            ),
            // 拍摄中
            onVideoRecordingMode: (state) => TakeVideoPage(
              cameraState: cameraState,
              maxVideoDuration: maxVideoDuration,
            ),

            // 启动摄像头
            onPreparingCamera: (state) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
