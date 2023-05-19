import 'package:flutter/material.dart';

/// 视图工具类
class UiUtils {
  /// 获取组件屏幕位置 offset
  static Offset getOffset(GlobalKey key) {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    Offset offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    return offset;
  }
}
