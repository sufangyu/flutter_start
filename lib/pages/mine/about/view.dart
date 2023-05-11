import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      appBar: AppBar(
        title: const Text('关于'),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 32.h),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.w)),
                ),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 120.w,
                  height: 120.h,
                ),
              ),
              SizedBox(height: 8.h),
              Text("V${ConfigStore.to.version}"),
              SizedBox(height: 32.h),
            ],
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  onTap: () => {},
                  title: Text("用户协议", style: TextStyle(fontSize: 16.sp)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
                const Divider(height: 1),
                ListTile(
                  onTap: () => {},
                  title: Text("隐私协议", style: TextStyle(fontSize: 16.sp)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                ),
              ],
            ),
          ),
          divider10Px(),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () => AppUpdateUtil().run(isBackground: false),
              title: Row(
                children: [
                  const Expanded(child: Text("检查更新")),
                  Text(ConfigStore.to.version),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
