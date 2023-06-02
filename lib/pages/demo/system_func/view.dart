import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SystemFuncPage extends GetView<SystemFuncController> {
  const SystemFuncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统能力'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          /// 剪贴板 ---------------------------------------------------------
          ElevatedButton(
            onPressed: () => SystemUtil.clipboardCopy('被复制的内容-点击复制'),
            child: const Text("点击复制"),
          ),
          ElevatedButton(
              onLongPress: () => SystemUtil.clipboardCopy('被复制的内容-长按复制'),
              onPressed: () {},
              child: const Text("长按复制")),
          ElevatedButton(
            onPressed: () async {
              String result = await SystemUtil.getClipboardData();
              LoggerUtil.debug("获取剪切板内容::$result");
            },
            child: const Text("获取剪切板内容"),
          ),
          const Divider(height: 50),

          /// 打电话、发邮件、打开外部浏览器、打开外部APP ---------------------------
          ElevatedButton(
            onPressed: () => SystemUtil.call('13211111111'),
            child: const Text("拨打电话"),
          ),
          ElevatedButton(
            onPressed: () => SystemUtil.sms('13211111111', body: "This is 内容"),
            child: const Text("发送短信"),
          ),
          ElevatedButton(
            onPressed: () => SystemUtil.mailto(
              '304683191@qq.com',
              subject: 'subject',
              body: "内容",
            ),
            child: const Text("发送邮件"),
          ),
          ElevatedButton(
            onPressed: () => SystemUtil.openBrowser('https://www.ithome.com'),
            child: const Text("打开外部浏览器"),
          ),
          ElevatedButton(
            onPressed: () =>
                SystemUtil.openApp('weixin://', errMsg: '打开失败,请检查是否安装'),
            child: const Text("打开外部应用:微信"),
          ),
          ElevatedButton(
            onPressed: () => SystemUtil.openApp('alipays://'),
            child: const Text("打开外部应用:支付宝"),
          ),
          ElevatedButton(
            onPressed: () => SystemUtil.openApp('taobao://'),
            child: const Text("打开外部应用:淘宝"),
          ),
        ],
      ),
    );
  }
}
