import 'package:flutter/services.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

/// 系统能力工具
class SystemUtil {
  /// 剪切板: 复制内容
  static clipboardCopy(String? text) {
    Clipboard.setData(ClipboardData(text: text ?? ''));
    toastInfo(msg: '复制成功');
  }

  /// 剪切板: 获取内容
  static Future<String> getClipboardData() async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  /// url_launcher: 打电话
  static call(String phone) async {
    Uri uri = Uri(scheme: 'tel', path: phone);
    await urlLauncher(uri);
  }

  /// url_launcher: 短信
  static sms(String phone, {String? body}) async {
    Uri uri = Uri(
      scheme: 'sms',
      path: phone,
      query: _encodeQueryParameters(<String, String>{
        'body': body ?? '',
      }),
    );
    await urlLauncher(uri);
  }

  /// 邮件
  static mailto(
    String emailAddress, {
    String? subject,
    String? body,
  }) async {
    Uri uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject ?? '',
        'body': body ?? '',
      }),
    );
    await urlLauncher(uri);
  }

  /// url_launcher: 打开浏览器
  /// * mode: 打开方式. 默认: 打开外部APP打开
  static openBrowser(
    String url, {
    LaunchMode? mode = LaunchMode.externalApplication,
  }) async {
    Uri uri = Uri.parse(url);

    await urlLauncher(uri);
  }

  /// url_launcher: 打开外部 APP
  /// * mode: 打开方式. 默认: 打开外部APP打开
  static openApp(
    String url, {
    LaunchMode? mode = LaunchMode.externalApplication,
    String? errMsg,
  }) async {
    Uri uri = Uri.parse(url);

    await urlLauncher(uri, errMsg: errMsg);
  }

  /// 触发打开手机APP、短信、打电话等
  /// * mode: 打开方式. 默认: 打开外部APP打开
  /// - errMsg: 打不开的提示信息
  static urlLauncher(
    Uri uri, {
    LaunchMode? mode = LaunchMode.externalApplication,
    String? errMsg,
  }) async {
    // LoggerUtil.debug("urlLauncher::$uri");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode!);
    } else {
      if (errMsg != null) {
        toastInfo(msg: errMsg);
      }
      throw Exception('Could not launch -> $errMsg');
    }
  }
}

/// 对中文内容进行解码
String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
