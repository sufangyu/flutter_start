import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GuidePage extends GetView<GuideController> {
  const GuidePage({super.key});

  /// 构建底层的引导图片
  _buildBackground(double width, double height) {
    return Positioned.fill(
      child: PageView(
        onPageChanged: (value) {
          controller.state.curIndex = value;
        },
        children: controller.guideImages.map<Widget>((uri) {
          return Image.asset(
            uri,
            width: width,
            height: height,
            fit: BoxFit.fill,
          );
        }).toList(),
      ),
    );
  }

  /// 引导切换点集合
  _buildDot() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60.h,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.guideImages.mapIndexed<Widget>((index, uri) {
          return Obx(() => AnimatedContainer(
                height: 12.h,
                width: index == controller.state.curIndex ? 30.w : 12.w,
                margin: const EdgeInsets.only(left: 16),
                duration: const Duration(milliseconds: 400),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ));
        }).toList(),
      ),
    );
  }

  /// 进入主程序
  _buildGoApplication() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 120.h,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => SizedBox(
              height: controller.state.curIndex == 2 ? 44.h : 0,
              width: controller.state.curIndex == 2 ? 160.w : 0,
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.w),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                onPressed: () => controller.gotoApplication(),
                child: const Text("立即体验"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: AndroidUtil.closeApp,
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.transparent,
          child: Stack(
            children: [
              _buildBackground(width, height),
              _buildDot(),
              _buildGoApplication(),
            ],
          ),
        ),
      ),
    );
  }
}
