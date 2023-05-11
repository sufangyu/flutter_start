import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';

class ScanPageController extends GetxController {
  final ScanController scanController = ScanController();

  /// 手电筒是否打开
  final RxBool _isFlashOn = false.obs;
  set isFlashOn(bool value) => _isFlashOn.value = !value;
  bool get isFlashOn => _isFlashOn.value;

  /// 切换手电筒模式
  void toggleTorchMode() {
    scanController.toggleTorchMode();
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
        scanController.pause();
        String? result = await Scan.parse(image.path);
        handleScanResult(result);
      },
    );
  }

  void handleScanResult(String? result) {
    LoggerUtil.debug("识别结果::$result");
    if (result == null) {
      Loading.error('二维码无法识别，请重试');
      return;
    }
    // TODO: 处理识别结果
    Get.offNamed(AppRoutes.DEBUG_SWITCH_ENV);
  }

  @override
  void onClose() {
    super.onClose();
    scanController.pause();
  }
}
