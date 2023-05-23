import 'package:flutter/material.dart';

import 'popup.widget.dart';

enum PopupPosition {
  top,
  bottom,
  right,
  left,
}

class PopupWindow {
  static OverlayEntry? overlayEntry;

  /// 打开 popup 弹窗层
  /// [position]
  /// [width、height] 弹窗尺寸（宽、高）
  /// [round] 是否显示圆角. 默认 false
  /// [closeOnMaskClick] 是否点击背景蒙层后关闭. 默认 true
  /// [closeable] 是否显示关闭按钮. 默认 false
  static open(
    BuildContext context, {
    required Widget child,
    PopupPosition? position,
    double? width,
    double? height,
    bool? round = false,
    bool? closeOnMaskClick = true,
    bool? closeable = false,
  }) {
    overlayEntry = OverlayEntry(
      builder: (context) => PopupWidget(
        onClose: close,
        position: position,
        round: round,
        closeOnMaskClick: closeOnMaskClick,
        closeable: closeable,
        width: width,
        height: height,
        child: child,
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  /// 关闭
  static close() {
    overlayEntry?.remove();
  }
}
