import 'package:flutter_start/common/widgets/index.dart';

/// 当前操作的时间
DateTime? _popTime;

/// 两次操作间隔时间
Duration _diff = const Duration(seconds: 1);

class AndroidUtil {
  /// 关闭按钮
  static Future<bool> closeApp() {
    if (_popTime == null || DateTime.now().difference(_popTime!) > _diff) {
      _popTime = DateTime.now();
      toastInfo(msg: "再点一次退出");
      return Future.value(false);
    } else {
      _popTime = DateTime.now();
      return Future.value(true);
    }
  }
}
