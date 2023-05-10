import 'package:flutter/material.dart';

import 'pages.dart';

/// 全局路由拦截器(自定义路由堆栈、分析异常日志等)
class RouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    String? name = route.settings.name;

    if (name != null) {
      AppPages.history.add(name);
    }
    // LoggerUtil.info("didPush::AppPages.history::${AppPages.history}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppPages.history.remove(route.settings.name);
    // LoggerUtil.info("didPop::AppPages.history::${AppPages.history}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute != null) {
      var index = AppPages.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      var name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > 0) {
          AppPages.history[index] = name;
        } else {
          AppPages.history.add(name);
        }
      }
    }
    // LoggerUtil.info("didReplace::AppPages.history::${AppPages.history}");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    AppPages.history.remove(route.settings.name);
    // LoggerUtil.info("didRemove::AppPages.history::${AppPages.history}");
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    // LoggerUtil.info("didStartUserGesture route: $route,previousRoute:$previousRoute");
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    // LoggerUtil.info("didStopUserGesture");
  }
}
