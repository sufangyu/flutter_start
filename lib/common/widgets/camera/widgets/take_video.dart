import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'countdown.dart';

class TakeVideoPage extends StatefulWidget {
  final CameraState cameraState;
  final Duration? maxVideoDuration;

  const TakeVideoPage({
    Key? key,
    required this.cameraState,
    this.maxVideoDuration,
  }) : super(key: key);

  @override
  State<TakeVideoPage> createState() => _TakeVideoPageState();
}

class _TakeVideoPageState extends State<TakeVideoPage> {
  @override
  void initState() {
    super.initState();

    // 订阅 cameraState 通知, 处理结果返回
    CameraUtils.listenCameraCaptureResult(
      context: context,
      captureMode: CaptureMode.video,
      cameraState: widget.cameraState,
    );
  }

  Widget _mainView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.black54,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 切换摄像头
            AwesomeCameraSwitchButton(state: widget.cameraState),
            // 拍摄按钮
            AwesomeCaptureButton(state: widget.cameraState),
            // 倒计时
            if (widget.cameraState is VideoRecordingCameraState &&
                widget.maxVideoDuration != null)
              Countdown(
                time: widget.maxVideoDuration!,
                callback: () {
                  // 倒计时结束后, 结束视频拍摄
                  (widget.cameraState as VideoRecordingCameraState)
                      .stopRecording();
                },
              )
            else
              const SizedBox(width: 32 + 20 * 2),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
