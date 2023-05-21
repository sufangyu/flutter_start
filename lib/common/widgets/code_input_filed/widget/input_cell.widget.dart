import 'dart:async';

import 'package:flutter/material.dart';

import '../model.dart';

class InputCell extends StatefulWidget {
  const InputCell({
    Key? key,
    required this.isFocused,
    required this.text,
    required this.type,
  }) : super(key: key);

  /// 是否聚焦当前
  final bool isFocused;

  /// 当前 cell 文本
  final String text;

  /// 输入框样式
  final CodeInputType type;

  @override
  State<InputCell> createState() => _InputCellState();
}

class _InputCellState extends State<InputCell> {
  // 聚焦时光标颜色，实现光标闪烁
  Color cursorColor = Colors.blue;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _autoToggleCursorColor();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  /// 定时自定切换光标颜色, 实现光标闪烁
  void _autoToggleCursorColor() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      cursorColor = Colors.transparent;
      if (mounted) {
        setState(() {});
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        cursorColor = Colors.blue;
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 未聚焦的格子
    Widget unFocusedCell = Center(
      child: Text(widget.text, style: const TextStyle(fontSize: 22)),
    );
    // 未聚焦的边框样式
    final unfocusedDecoration = BoxDecoration(
      border: widget.type == CodeInputType.underLine
          ? Border(bottom: BorderSide(width: 1, color: Colors.grey.shade300))
          : Border.all(color: Colors.grey.shade300),
    );

    // 聚焦的格子
    Widget focusedCell = Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: cursorColor,
      width: 2,
    );

    // 聚焦的边框样式
    final focusedDecoration = BoxDecoration(
      color: Colors.white,
      border: widget.type == CodeInputType.underLine
          ? const Border(bottom: BorderSide(width: 1, color: Colors.blue))
          : Border.all(color: Colors.blue, width: 1.5),
    );

    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      decoration: widget.isFocused ? focusedDecoration : unfocusedDecoration,
      child: widget.isFocused ? focusedCell : unFocusedCell,
    );
  }
}
