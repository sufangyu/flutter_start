import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/config/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(0),
      //   child: Container(),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCommonOperate(),
              divider10Px(),
              _buildCommonWidget(),
              divider10Px(),
              Container(
                padding: EdgeInsets.all(16.w),
                child: const Column(
                  children: [
                    Text("构建版本：${EnvConfig.version}"),
                    Text("API 默认环境：${EnvConfig.env}"),
                    Text("安卓渠道：${EnvConfig.channel}"),
                    Text("可切环境：${EnvConfig.canSwitchEnv}"),
                    Text("可代理抓包：${EnvConfig.canProxy}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommonOperate() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            // color: Colors.red,
            child: Text(
              "常用功能",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: controller.list.length,
            itemBuilder: (context, index) =>
                _buildGridItem(context, controller.list, index),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            // color: Colors.red,
            child: Text(
              "常用组件",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: controller.widgetList.length,
            itemBuilder: (context, index) =>
                _buildGridItem(context, controller.widgetList, index),
          ),
        ],
      ),
    );
  }

  /// Item
  Widget _buildGridItem(BuildContext context, List<Entry> list, int index) {
    var item = list[index];
    return Container(
      alignment: Alignment.center,
      // decoration: const BoxDecoration(color: Colors.red),
      child: GestureDetector(
        onTap: () {
          // LoggerUtil.info("item::${item.path != null} - ${item.path}");
          if (item.path != null) {
            Get.toNamed(item.path!);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(item.icon, size: 32.w, color: Colors.blue),
            SizedBox(height: 8.h),
            Text(
              item.label,
              style: TextStyle(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
