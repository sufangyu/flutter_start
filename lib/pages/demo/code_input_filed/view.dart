import 'package:flutter/material.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CodeInputPage extends GetView<CodeInputController> {
  const CodeInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('验证码输入框'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("4位底部线条输入框"),
          Container(
            margin: const EdgeInsets.all(20),
            height: 120,
            alignment: Alignment.center,
            // color: Colors.brown,
            child: CodeInputFiled(
              length: 4,
              type: CodeInputType.underLine,
              onChanged: (String code) {
                LoggerUtil.debug("输入完成, 触发登录校验::$code");
              },
            ),
          ),
          const Text("4位底部线条输入框"),
          Container(
            margin: const EdgeInsets.all(20),
            height: 120,
            alignment: Alignment.center,
            // color: Colors.brown,
            child: CodeInputFiled(
              length: 6,
              onChanged: (String code) {
                LoggerUtil.debug("输入完成, 触发登录校验::$code");
              },
            ),
          ),
        ],
      ),
    );
  }
}
