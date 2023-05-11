import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryElement,
      appBar: PreferredSize(
        // 高度设置为0时, 则为空白 appBar
        preferredSize: Size.fromHeight(24.h),
        child: AppBar(
          // backgroundColor: Colors.yellow,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 20.w),
              width: 36.w,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(Icons.crop_free),
                onPressed: () => Get.toNamed(AppRoutes.SCAN),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.w),
              width: 36.w,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(Icons.notifications_on_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 10.h),
              _buildCommonOperate(),
              SizedBox(height: 10.h),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.GUIDE_SCREEN),
                      title: Text("引导页", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.add_alert_outlined),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.MINE_SETTING),
                      title: Text("设置", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
              divider10Px(),
              Container(
                color: Colors.white,
                child: ListTile(
                  onTap: () => Get.toNamed(AppRoutes.MINE_ABOUT),
                  title: Text("关于", style: TextStyle(fontSize: 16.sp)),
                  leading: const Icon(Icons.question_answer_outlined),
                ),
              ),
              // 切换环境
              !ConfigStore.to.isRelease
                  ? Column(
                      children: [
                        divider10Px(),
                        Container(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () =>
                                Get.toNamed(AppRoutes.DEBUG_SWITCH_ENV),
                            title: Text(
                              "切换API环境",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            leading: const Icon(Icons.bug_report_outlined),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  /// 头部用户信息
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      // padding: EdgeInsets.all(20.w),
      child: Obx(
        () => ListTile(
          visualDensity: const VisualDensity(vertical: 4), // to expand
          contentPadding: EdgeInsets.all(16.w),
          // dense: true,
          onTap: () {
            if (UserStore.to().isLogin == false) {
              Get.toNamed(AppRoutes.SIGN_IN);
            }
          },
          leading: UserStore.to().isLogin
              ? netImageCached(
                  "https://avatars.githubusercontent.com/u/1852629?v=4",
                  width: 48.w,
                  height: 48.h,
                )
              : ClipRRect(
                  borderRadius: Radii.k6pxRadius,
                  child: Image.asset(
                    "assets/images/default-image.png",
                    width: 48.w,
                    height: 48.w,
                  ),
                ),

          title: Text(
            UserStore.to().profile.displayName ?? '立即登录',
            style: TextStyle(fontSize: 18.sp),
          ),
          trailing: UserStore.to().isLogin
              ? null
              : const Icon(Icons.keyboard_arrow_right),
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
            itemBuilder: (context, index) => _buildGridItemView(context, index),
          ),
        ],
      ),
    );
  }

  /// Item
  Widget _buildGridItemView(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      // decoration: const BoxDecoration(color: Colors.red),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            controller.list[index]["icon"],
            size: 32.w,
            color: Colors.blue,
          ),
          SizedBox(height: 10.h),
          Text(
            controller.list[index]["label"],
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
