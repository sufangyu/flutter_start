import 'package:flutter/material.dart';

import 'watermark.widget.dart';

/// 水印工具类 单例 instance
/// 使用方式：
/// * 获取实例: WaterMarkInstance instance = WaterMarkInstance();
/// * 添加水印: instance.addWatermark(context, "水印文本");
/// * 删除水印: instance.removeWatermark();
class WaterMarkInstance {
  WaterMarkInstance._internal();

  factory WaterMarkInstance() => _instance;
  static final WaterMarkInstance _instance = WaterMarkInstance._internal();

  OverlayEntry? _overlayEntry;

  void addWatermark(
    BuildContext context,
    String watermark, {
    int rowCount = 3,
    int columnCount = 8,
    TextStyle? textStyle,
  }) {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (context) => WatermarkWidget(
        rowCount: rowCount,
        columnCount: columnCount,
        text: watermark,
        textStyle: textStyle ??
            TextStyle(
              color: Colors.black.withOpacity(0.03),
              fontSize: 18,
            ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeWatermark() async {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
