import 'dart:math';

import 'package:flutter/material.dart';

/// 水印组件样式
/// * rowCount: 当前屏幕宽度中 展示多少列水印
/// * columnCount: 当前屏幕高度中，展示多少行水印
/// * watermark: 水印展示的文字
/// * textStyle: 文字的样式
class WatermarkWidget extends StatelessWidget {
  const WatermarkWidget({
    Key? key,
    required this.rowCount,
    required this.columnCount,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  /// 当前屏幕宽度中 展示多少列水印
  final int rowCount;

  /// 当前屏幕高度中，展示多少行水印
  final int columnCount;

  /// 水印展示的文字
  final String text;

  /// 文字的样式
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(children: _buildColumnWidgets()),
    );
  }

  List<Widget> _buildColumnWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < columnCount; i++) {
      final widget = Expanded(
        child: Row(children: _buildRowWidgets()),
      );
      list.add(widget);
    }
    return list;
  }

  _buildRowWidgets() {
    List<Widget> list = [];
    for (var i = 0; i < rowCount; i++) {
      final widget = Expanded(
        child: Center(
          child: Transform.rotate(
            angle: -40 * pi / 180,
            child: Column(
              children: [
                Text(text, style: textStyle),
                Text(
                  "v1.0.0",
                  style: textStyle.merge(const TextStyle(fontSize: 16)),
                )
              ],
            ),
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }
}
