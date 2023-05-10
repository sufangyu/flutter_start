import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class DialogController extends GetxController {
  /// 简单弹窗
  void openDialog(String placement) {
    Get.context?.showCustomDialog(
      DialogBase(
        title: '控制弹窗显示位置',
        body: const Text(
          "可以根据传入的参数不同，控制弹窗显示的位置所在。",
          style: TextStyle(fontSize: 20),
        ),
        placement:
            placement == 'bottom' ? Placement.bottomCenter : Placement.center,
        // confirmText: 'Absolutely!',
        onTap: () => debugPrint('agreed'),
      ),
    );
  }

  /// 自定义遮罩层颜色
  void openDialogMaskColor() {
    Get.context?.showCustomDialog(
      DialogBase(
        title: '自定义遮罩层颜色',
        body: const Text(
          "可以通过设置 maskColor，设置遮罩层颜色。",
          style: TextStyle(fontSize: 20),
        ),
        maskColor: Colors.blue.withOpacity(0.7),
        onTap: () => debugPrint('agreed'),
      ),
    );
  }

  /// 自定义按钮
  void openDialogActions() {
    Get.context?.showCustomDialog(
      DialogBase(
        title: '自定义底部按钮',
        body: const Text(
          "可通过设置 actions，完全自定义弹窗的底部按钮。",
          style: TextStyle(fontSize: 20),
        ),
        placement: Placement.bottomCenter,
        actions: Row(
          children: [
            CupertinoButton.filled(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 40.w),
              onPressed: () {
                Get.back();
                Loading.info("点了取消");
              },
              child: const Text("取消", style: TextStyle(fontSize: 18)),
            ),
            SizedBox(width: 16.w),
            CupertinoButton.filled(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 66.w),
              onPressed: () {
                Get.back();
                Loading.info("点了确认");
              },
              child: const Text("确认", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
