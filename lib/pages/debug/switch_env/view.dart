import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SwitchEnvPage extends GetView<SwitchEnvController> {
  const SwitchEnvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('切换环境'),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color(0xffff2f2f2),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Column(
                children: [
                  Text("当前环境",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.sp,
                      )),
                  SizedBox(height: 4.h),
                  Obx(
                    () => Text(
                      "${controller.curEnvConfig.label}(${controller.curEnvConfig.code})",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _buildEnvList(),
                ),
              ),
            ),
            // const Text('sign_in'),
            // const Divider(),
            // Text(ConfigStore.to.isAlreadyOpen.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEnvList() {
    List<Widget> envList = <Widget>[
      ListTile(
        title: const Text("重置默认环境"),
        onTap: () => controller.resetDefaultEnv(),
      ),
      const Divider(height: 1),
    ];

    controller.apiEnvList.map((env) {
      List<Widget> widgets = [
        ListTile(
          title: Text("${env.label}-${env.code}"),
          onTap: () => controller.switchEnv(env),
        ),
        const Divider(height: 1),
      ];

      envList.add(Column(children: widgets));
    }).toList();

    return envList;
  }
}
