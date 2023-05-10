import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'state.dart';

class DetailController extends GetxController {
  DetailController();

  /// 响应式成员变量
  final state = DetailState();

  /// WebViewController
  late final WebViewController webController;

  @override
  void onInit() {
    super.onInit();

    state.newsDetail = Get.arguments['detail'];
    String webUri = "https://juejin.cn/post/7196698315835260984";

    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            LoggerUtil.info("webview onProgress==============::$progress");
          },
          onPageStarted: (String url) {
            LoggerUtil.info("webview onPageStarted==============");
          },
          onPageFinished: (String url) async {
            LoggerUtil.info("webview onPageFinished==============::$url");
            state.isPageFinished = true;

            await Future.delayed(const Duration(milliseconds: 50));
            await webController.runJavaScript('''
              try {
                // 删除元素
                function removeElement(elementName){
                  let _element = document.getElementById(elementName);
                  if(!_element) {
                    _element = document.querySelector(elementName);
                  }
                  if(!_element) {
                    return;
                  }
                  let _parentElement = _element.parentNode;
                  if(_parentElement){
                    _parentElement.removeChild(_element);
                  }
                }
                removeElement('.app-open-drawer');
                removeElement('.recommended-area');
                removeElement('.category-course-recommend');
                removeElement('.app-open-button');
              } catch {}
            ''');

            /// 自动获取内容高并设置
            var message = await webController.runJavaScriptReturningResult(
                'document.scrollingElement.scrollHeight');
            state.webViewHeight = double.parse(message.toString());
          },
          onWebResourceError: (WebResourceError error) {
            LoggerUtil.debug("WebResourceError::$error");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.jueji.cn')) {
              toastInfo(msg: request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(webUri));
  }
}
