import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

StreamSubscription? _sub;

/// 监听、处理 Web 打开 APP
class UniLinksUtil {
  /// 监听 Web 打开 APP
  static Future<void> listen() async {
    Uri? initialUri;

    // App 未打开状态: 捕获 scheme
    try {
      initialUri = await getInitialUri();
      schemeJump(initialUri);
    } on PlatformException {
      LoggerUtil.error('Failed to get initial link.');
    } on FormatException {
      LoggerUtil.error('Failed to parse the initial link as Uri.');
    }

    // App 打开状态: 监听 scheme
    _sub = uriLinkStream.listen((Uri? uri) {
      schemeJump(uri);
    }, onError: (err) {
      LoggerUtil.error(err.toString());
    });
  }

  /// 销毁
  /// NOTE: Don't forget to call _sub.cancel() in dispose()
  static void dispose() {
    _sub?.cancel();
  }

  /// 解析 Scheme 跳转页面
  /// 需要处理同一页面, 不同的参数情况 !!!
  static void schemeJump(Uri? uri) {
    LoggerUtil.debug("link::$uri, ${uri?.host}, ${uri?.query}");
    if (uri == null) {
      return;
    }

    // 保留第一个页面, 关闭所有, 再重新打开
    Get.offNamedUntil(
      AppRoutes.DEBUG_SCHEME_JUMP,
      (route) => route.isFirst,
      arguments: {
        "uri": uri.toString(),
        "host": uri.host,
        "query": uri.query,
      },
    );
  }
}
