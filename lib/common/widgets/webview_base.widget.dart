import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewBasePage extends StatefulWidget {
  /// 网页路径
  final String url;

  /// 网页标题
  final String title;

  const WebviewBasePage({
    Key? key,
    required this.url,
    required this.title,
  }) : super(key: key);

  @override
  State<WebviewBasePage> createState() => _WebviewBasePageState();
}

class _WebviewBasePageState extends State<WebviewBasePage> {
  late final WebViewController webController;
  late double webViewHeight = 100.0;

  @override
  void initState() {
    super.initState();

    _loadWeb(widget.url);
  }

  /// 加载网页
  void _loadWeb(String url) {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            await Future.delayed(const Duration(milliseconds: 50));
            await webController.runJavaScript("");

            /// 自动获取内容高并设置
            var message = await webController.runJavaScriptReturningResult(
                'document.scrollingElement.scrollHeight');
            LoggerUtil.info("webview onProgress==============::$message");

            setState(() {
              webViewHeight = double.parse(message.toString());
            });
          },
          onWebResourceError: (WebResourceError error) {
            LoggerUtil.debug("WebResourceError::$error");
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: webViewHeight,
          child: WebViewWidget(controller: webController),
        ),
      ),
    );
  }
}
