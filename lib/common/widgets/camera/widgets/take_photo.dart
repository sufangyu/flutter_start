import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class TakePhotoPage extends StatefulWidget {
  final CameraState cameraState;

  const TakePhotoPage({
    Key? key,
    required this.cameraState,
  }) : super(key: key);

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  @override
  void initState() {
    super.initState();

    // 订阅 cameraState 通知, 处理结果返回
    CameraUtils.listenCameraCaptureResult(
      context: context,
      captureMode: CaptureMode.photo,
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
            // 右侧空间
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
