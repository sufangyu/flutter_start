import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class SystemFuncController extends GetxController {
  @override
  void onClose() {
    super.onClose();

    stopListenConnectivity();
  }

  /// 网络连接 ------------------------
  StreamSubscription<ConnectivityResult>? subscription;

  void getConnectivity() async {
    ConnectivityResult result = await SystemUtil.getConnectivity();
    LoadingUtil.success("网络类型::$result");
  }

  void startListenConnectivity() async {
    subscription = SystemUtil.startListenConnectivity(
      onChange: (ConnectivityResult result) {
        LoadingUtil.success("网络类型::$result");
      },
    );
  }

  void stopListenConnectivity() {
    SystemUtil.stopListenConnectivity(subscription);
  }
}
