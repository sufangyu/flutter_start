import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.secondaryElement}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(color: bgColor),
  );
}
