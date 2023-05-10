import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 协议弹窗
class ProtocolModel {
  late TapGestureRecognizer _registerProtocolRecognizer;
  late TapGestureRecognizer _privacyProtocolRecognizer;

  /// 显示弹窗，返回结果
  /// （要延迟执行：https://blog.csdn.net/abs_botton/article/details/118188012）
  Future<bool> showProtocol(BuildContext context) async {
    _registerProtocolRecognizer = TapGestureRecognizer();
    _privacyProtocolRecognizer = TapGestureRecognizer();

    bool isShow = await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoAlertDialog(context);
      },
    );
    LoggerUtil.info("ProtocolModel::结果::$isShow");

    //销毁
    _registerProtocolRecognizer.dispose();
    _privacyProtocolRecognizer.dispose();
    return Future.value(isShow);
  }

  /// 弹窗
  CupertinoAlertDialog _cupertinoAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("个人信息保护指引"),
      actions: [
        CupertinoDialogAction(
          child: const Text("退出应用"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: const Text("同意"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Container(
        height: 120.h,
        padding: EdgeInsets.all(8.w),
        child: SingleChildScrollView(child: _buildContent(context)),
      ),
    );
  }

  /// 弹窗主内容
  _buildContent(BuildContext context) {
    String userPrivateProtocol =
        "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。如果您不能接受本协议中的全部条款，请勿开始使用本产品。";

    return RichText(
      text: TextSpan(
        text: "请您在使用本产品之前仔细阅读",
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: "《用户协议》",
            style: const TextStyle(color: Colors.blue),
            recognizer: _registerProtocolRecognizer
              ..onTap = () => _openUserProtocol(context),
          ),
          const TextSpan(text: "与", style: TextStyle(color: Colors.black87)),
          TextSpan(
            text: "《隐私政策》",
            style: const TextStyle(color: Colors.blue),
            recognizer: _privacyProtocolRecognizer
              ..onTap = () => _openPrivateProtocol(context),
          ),
          TextSpan(
            text: userPrivateProtocol,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  /// 查看用户协议
  void _openUserProtocol(BuildContext context) {
    _gotoWebview(
      context,
      title: "用户协议",
      url:
          "https://lf3-cdn-tos.draftstatic.com/obj/ies-hotsoon-draft/juejin/86857833-55f6-4d9e-9897-45cfe9a42be4.html",
    );
  }

  /// 查看隐私协议
  void _openPrivateProtocol(BuildContext context) {
    _gotoWebview(
      context,
      title: "隐私协议",
      url:
          "https://lf3-cdn-tos.draftstatic.com/obj/ies-hotsoon-draft/juejin/86857833-55f6-4d9e-9897-45cfe9a42be4.html",
    );
  }

  /// 跳转 Webview
  void _gotoWebview(
    BuildContext context, {
    required String title,
    required String url,
  }) {
    PageRoute pageRoute = CupertinoPageRoute(builder: (context) {
      return WebviewBasePage(title: title, url: url);
    });

    Navigator.of(context).push(pageRoute);
  }
}
