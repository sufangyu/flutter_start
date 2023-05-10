import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetWidget {
  /// 显示底部抽屉
  /// [scrollControlled] 内容溢出
  /// [bodyColor] 主内容的背景色. 默认 白色(Colors.white)
  /// [bodyPadding] 主内容的内边距. 默认 8.w
  /// [borderRadius] 边框圆角形状. 默认 topLeft:16.w、topRight:16.w
  static Future<T?> show<T>(
    BuildContext context,
    Widget body, {
    bool scrollControlled = false,
    Color bodyColor = Colors.white,
    EdgeInsets? bodyPadding,
    BorderRadius? borderRadius,
  }) {
    Radius radius = Radius.circular(16.w);
    borderRadius ??= BorderRadius.only(topLeft: radius, topRight: radius);
    bodyPadding ??= EdgeInsets.all(8.w);
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    // Toolbar 高度
    double appBartHeight = kToolbarHeight;
    // 屏幕尺寸信息
    Size screen = MediaQuery.of(context).size;

    return showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: bodyColor,
      isScrollControlled: scrollControlled, // 弹窗内容自行管理
      constraints: BoxConstraints(
        maxHeight: (screen.height - appBartHeight) * 0.95 - viewPadding.top,
      ),
      shape: RoundedRectangleBorder(borderRadius: borderRadius), // 形状
      // barrierColor: Colors.black.withOpacity(0.5), // 遮罩层样式
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: bodyPadding!.left,
            top: bodyPadding.top,
            right: bodyPadding.right,
            bottom: bodyPadding.bottom + viewPadding.bottom,
          ),
          child: body,
        ),
      ),
    );
  }
}
