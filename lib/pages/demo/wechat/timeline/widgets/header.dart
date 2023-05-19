import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/entities/wechat.entity.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/pages/demo/wechat/timeline/index.dart';
import 'package:get/get.dart';

import '../entity.dart';

class TimelineHeader extends GetView<WechatTimelineController> {
  const TimelineHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // 屏幕宽度
    final double width = MediaQuery.of(context).size.width;
    UserEntity? user = controller.state.user;

    return user == null
        ? const SizedBox.shrink()
        : Stack(
            children: [
              // 背景
              SizedBox(
                width: width,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: netImageCached(
                    user.cover ?? "",
                    height: width * 0.65,
                    borderRadius: BorderRadius.zero,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // 昵称、头像
              Positioned(
                right: 16.w,
                bottom: 4.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.nickname ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        height: 1.6,
                        fontWeight: FontWeight.bold,
                        // 文字阴影
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    netImageCached(user.avator ?? "", height: 56, width: 56),
                  ],
                ),
              ),
            ],
          );
  }
}
