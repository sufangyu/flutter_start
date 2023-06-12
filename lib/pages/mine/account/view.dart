import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/config/index.dart';
import 'package:get/get.dart';

import 'account.style.dart';
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
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.GUIDE_SCREEN),
                      title: Text("引导页", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.add_alert_outlined),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.MINE_SETTING),
                      title: Text("设置", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.settings),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.MINE_SETTING),
                      title: Text("意见反馈", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.opacity),
                    ),
                  ],
                ),
              ),
              divider10Px(),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.MINE_ABOUT),
                      title: Text("帮助与客服", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.help_outline),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      onTap: () => Get.toNamed(AppRoutes.MINE_ABOUT),
                      title: Text("关于", style: TextStyle(fontSize: 16.sp)),
                      leading: const Icon(Icons.question_answer_outlined),
                    ),
                  ],
                ),
              ),

              /// 切换环境入口
              EnvConfig.canSwitchEnv
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
                  : const SizedBox.shrink(),
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
        () => Column(
          children: [
            ListTile(
              visualDensity: const VisualDensity(vertical: 4), // to expand
              contentPadding: EdgeInsets.all(16.w),
              // dense: true,
              onTap: () {
                if (UserStore.to.isLogin == false) {
                  Get.toNamed(AppRoutes.SIGN_IN);
                }
              },
              leading: UserStore.to.isLogin
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
                UserStore.to.profile.displayName ?? '立即登录',
                style: TextStyle(fontSize: 18.sp),
              ),
              trailing: UserStore.to.isLogin
                  ? null
                  : const Icon(Icons.keyboard_arrow_right),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("1500", style: textStyleHeaderCellTitle),
                    Text("点赞", style: textStyleHeaderCellDesc),
                  ],
                ),
                Column(
                  children: [
                    Text("224", style: textStyleHeaderCellTitle),
                    Text("收藏", style: textStyleHeaderCellDesc),
                  ],
                ),
                Column(
                  children: [
                    Text("0", style: textStyleHeaderCellTitle),
                    Text("关注", style: textStyleHeaderCellDesc),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
