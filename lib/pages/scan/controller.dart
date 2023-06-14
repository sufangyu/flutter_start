import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPageController extends GetxController with WidgetsBindingObserver {
  late MobileScannerController? cameraController = MobileScannerController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    disposeCamera();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // LoggerUtil.debug('state::$state');
    // 根据不同的场景设置扫描暂停、开始, 以优化性能
    switch (state) {
      case AppLifecycleState.resumed:
        cameraController?.start();
        break;
      case AppLifecycleState.inactive:
        cameraController?.stop();
        break;
      case AppLifecycleState.paused:
        cameraController?.stop();
        break;
      case AppLifecycleState.detached:
        disposeCamera();
        break;
    }
  }

  void disposeCamera() {
    cameraController?.stop();
    cameraController?.dispose();
    cameraController = null;
  }

  /// 手电筒是否打开
  final RxBool _isFlashOn = false.obs;
  set isFlashOn(bool value) => _isFlashOn.value = !value;
  bool get isFlashOn => _isFlashOn.value;

  /// 切换手电筒模式
  void toggleTorchMode() {
    cameraController?.toggleTorch();
    _isFlashOn.value = !_isFlashOn.value;
  }

  /// 扫描识别图库中二维码
  Future<void> scanPhoto() async {
    // 1^3^1001
    PermissionUtil.checkPermission(
      permissions: [Permission.photos],
      onSuccess: () async {
        LoggerUtil.debug("扫描识别图库中二维码");
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );

        if (image == null) {
          return;
        }

        bool? result = await cameraController?.analyzeImage(image.path);
        LoggerUtil.debug("识别本地图片结果::$result");
        if (result == false) {
          LoadingUtil.toast('无法识别图片二维码/条形码');
        }
      },
    );
  }

  /// 扫描结果
  void onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    String? result = barcodes.first.rawValue;

    if (result == null) {
      return;
    }

    LoggerUtil.debug("scan capture::$result");
    cameraController?.stop();
    VibrateUtil.light();

    // 是否返回值给上一个页面
    bool? isInput = Get.arguments?['isInput'];
    if (isInput == true) {
      Get.back<String>(result: result);
      return;
    }

    // TODO: 处理识别结果
    Get.offNamed(AppRoutes.DEBUG_SWITCH_ENV);
  }
}
