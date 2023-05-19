import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 视频预览播放器
class VideoPlayerPreviewWidget extends StatefulWidget {
  /// 视频 asset
  final AssetEntity? initAsset;

  /// 完成压缩回调
  final Function(CompressMediaFile)? onCompleted;

  /// chewie 视频播放控制器
  final ChewieController? controller;

  const VideoPlayerPreviewWidget({
    Key? key,
    this.initAsset,
    this.onCompleted,
    this.controller,
  }) : super(key: key);

  @override
  State<VideoPlayerPreviewWidget> createState() =>
      _VideoPlayerPreviewWidgetState();
}

class _VideoPlayerPreviewWidgetState extends State<VideoPlayerPreviewWidget> {
  /// video 视频控制器
  VideoPlayerController? _videoController;

  /// chewie 控制器
  ChewieController? _controller;

  /// 压缩消息订阅
  Subscription? _subscription;

  /// 资源 asset
  AssetEntity? _asset;

  /// 是否载入中
  bool _isLoading = true;

  /// 是否错误
  bool _isError = false;

  /// 压缩进度
  double _progress = 0;

  @override
  void initState() {
    super.initState();

    _asset = widget.initAsset;
    _subscribeProgress();

    if (mounted) {
      onLoad();
    }
  }

  @override
  void dispose() {
    super.dispose();

    if (widget.controller == null) {
      _controller?.dispose();
    }
    _subscription?.unsubscribe();
    _subscription = null;
    // 取消压缩、删除压缩缓存文件
    VideoCompress.cancelCompression();
    VideoCompress.deleteAllCache();
  }

  void onLoad() async {
    // 初始界面状态
    setState(() {
      _isLoading = _asset != null;
      _isError = _asset == null;
    });

    // 安全检查, 容错
    if (_asset == null) {
      return;
    }

    // 清理资源，释放播放器对象
    _videoController?.dispose();

    try {
      File file = await _getFile();
      // 开始视频压缩
      CompressMediaFile result = await CompressUtil.video(file);
      LoggerUtil.info("开始视频压缩::");

      // video_player 初始化
      _videoController = VideoPlayerController.file(result.video!.file!);
      await _videoController!.initialize();

      // chewie 初始化
      _controller = widget.controller ??
          ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: false,
            looping: false,
            autoInitialize: true,
            showOptions: false,
            cupertinoProgressColors: ChewieProgressColors(
              playedColor: Colors.blueAccent,
            ),
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.blueAccent,
            ),
            allowPlaybackSpeedChanging: false,
            deviceOrientationsOnEnterFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
              DeviceOrientation.portraitUp,
            ],
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitUp,
            ],
          );

      if (widget.onCompleted != null) {
        widget.onCompleted!(result);
      }
    } catch (err) {
      LoggerUtil.error(err.toString());
      LoadingUtil.error('Video file error');
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 文件 file
  Future<File> _getFile() async {
    File? file = await _asset?.file;
    if (file == null) throw 'No file';
    return file;
  }

  /// 订阅压缩进度
  _subscribeProgress() {
    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      debugPrint('progress: $progress');
      setState(() {
        _progress = progress;
      });
    });
  }

  Widget _mainView() {
    // 默认空组件
    Widget ws = const SizedBox.shrink();

    if (_isLoading) {
      // 压缩进度
      ws = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 进度状态 icon
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          // 进度状态文本
          Text(
            '${_progress.toStringAsFixed(2)}%',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black45,
            ),
          ),
        ],
      );
    } else {
      if (_controller != null && !_isError) {
        ws = Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Chewie(controller: _controller!),
        );
      }
    }

    // 按比例组件包裹
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(color: Colors.grey[100], child: ws),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
