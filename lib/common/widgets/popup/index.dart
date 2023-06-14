import 'package:flutter/material.dart';

import 'popup.widget.dart';

/// 弹窗出现位置. 默认 bottom
enum PopupPosition {
  top,
  bottom,
  right,
  left,
}

/// 弹窗关闭按钮位置. 默认 topRight
enum PopupClosePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class PopupWindow {
  static OverlayEntry? overlayEntry;

  // static GlobalKey popupKey = GlobalKey();

  /// 打开 popup 弹窗层
  /// [position]
  /// [width、height] 弹窗尺寸（宽、高）
  /// [round] 是否显示圆角. 默认 false
  /// [title] 弹窗标题
  /// [closeable] 是否显示关闭按钮. 默认 false
  /// [closeOnMaskClick] 是否点击背景蒙层后关闭. 默认 true
  /// [onClosed] 关闭弹窗回调函数
  static open(
    BuildContext context, {
    required Widget child,
    PopupPosition? position,
    double? width,
    double? height,
    bool? round = false,
    Widget? title,
    bool? closeable = false,
    PopupClosePosition? closePosition,
    bool? closeOnMaskClick = true,
    Function()? onClosed,
  }) {
    overlayEntry = OverlayEntry(
      builder: (context) => PopupWidget(
        key: popupKey,
        position: position,
        width: width,
        height: height,
        round: round,
        title: title,
        closeable: closeable,
        closePosition: closePosition,
        closeOnMaskClick: closeOnMaskClick,
        onClosed: onClosed,
        onCloseOverlay: close,
        child: child,
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  /// 关闭
  static close() async {
    // await popupKey.currentState?.onClose();
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
