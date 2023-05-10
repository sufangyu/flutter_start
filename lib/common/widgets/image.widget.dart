import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 缓存图片
Widget netImageCached(
  /// 图片路径
  String url, {
  /// 宽度
  double width = 36,

  /// 高度
  double height = 36,

  /// 是否是圆形
  bool isCircular = false,

  /// 外边距
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      height: height.h,
      width: width.w,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius:
            isCircular ? BorderRadius.circular(width) : Radii.k6pxRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        height: height.h,
        width: width.w,
        margin: margin,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(strokeWidth: 3),
      );
    },
    errorWidget: (context, url, error) {
      return Container(
        height: height.h,
        width: width.w,
        margin: margin,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: Radii.k6pxRadius,
          color: Colors.black12,
        ),
        child: const Icon(
          Icons.error_outline,
          size: 36,
          color: Colors.black38,
        ),
      );
    },
  );
}
