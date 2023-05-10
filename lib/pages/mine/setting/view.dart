import 'controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryElement,
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 8.h),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(title: const Text("编辑资料"), onTap: () {}),
                  const Divider(),
                  ListTile(title: const Text("账号设置"), onTap: () {}),
                  const Divider(),
                  ListTile(title: const Text("消息设置"), onTap: () {}),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: const Text("切换语言"),
                    onTap: () {
                      BottomSheetWidget.show(
                        context,
                        _buildSelectLanguage(context),
                        bodyPadding: const EdgeInsets.all(0),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("切换主题"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: () async {
                  await UserStore.to().onLogout();
                  Get.back();
                },
                title: Center(
                  child: Text(
                    "退出登录",
                    style: TextStyle(fontSize: 16.sp, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建语言选择
  Widget _buildSelectLanguage(BuildContext context) {
    Map<String, String> languageDescription = {
      "en_US": "英文",
      "zh_Hans": "中文简体",
      "zh_HK": "中文繁体",
    };

    return Column(
      children: ConfigStore.to.languages.map((Locale locale) {
        String code = locale.toString();
        String langStr = languageDescription[code]!;
        int curIndex = ConfigStore.to.languages.indexOf(locale);
        bool isLast = curIndex == ConfigStore.to.languages.length - 1;

        List<Widget> widgets = <Widget>[
          ListTile(
            title: Center(child: Text(langStr)),
            onTap: () {
              // Locale locale = const Locale('en', 'US');
              _setLanguage(
                context: context,
                locale: locale,
                msg: '已切换至$langStr',
              );
            },
          ),
          isLast ? Container() : const Divider(height: 1),
        ];

        // 添加取消按钮
        if (isLast) {
          widgets.addAll(<Widget>[
            divider10Px(),
            ListTile(
              title: const Center(child: Text("取消")),
              onTap: () => _hideBottomSheet(context),
            ),
          ]);
        }

        return Column(children: widgets);
      }).toList(),
    );
  }

  _setLanguage({
    required BuildContext context,
    required Locale locale,
    required String msg,
  }) {
    ConfigStore.to.onLocaleUpdate(locale);
    _hideBottomSheet(context);
    toastInfo(msg: msg);
  }

  _hideBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }
}
