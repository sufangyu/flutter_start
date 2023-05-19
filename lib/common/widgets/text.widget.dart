import 'package:flutter/material.dart';

/// 折叠显示更多文本组件
class TextMaxLinesWidget extends StatefulWidget {
  const TextMaxLinesWidget({
    Key? key,
    required this.content,
    this.maxLines,
    this.style,
    this.expandLabel,
    this.retractLabel,
    this.hasRetract,
    this.labelStyle,
  }) : super(key: key);

  /// 文本内容
  final String content;

  /// 文本样式
  final TextStyle? style;

  /// 最多显示几行. 默认: 3
  final int? maxLines;

  /// 展开文本. 默认: 全文
  final String? expandLabel;

  /// 收起文本. 默认: 收起
  final String? retractLabel;

  /// 是否显示收起文本. 默认: false
  final bool? hasRetract;

  /// 展开、收取文本样式
  final TextStyle? labelStyle;

  @override
  State<TextMaxLinesWidget> createState() => _TextMaxLinesWidgetState();
}

class _TextMaxLinesWidgetState extends State<TextMaxLinesWidget> {
  // 内容
  late final String _content;
  // 最大行数
  late final int _maxLines;
  // 内容文本样式
  late final TextStyle? _style;
  // 是否展开
  late bool _isExpansion = false;
  // 展开文本
  late final String? _expandLabel;
  // 收起文本
  late final String? _retractLabel;
  // 是否显示收起文本
  late final bool? _hasRetract;
  // 展开、收取文本样式
  late final TextStyle? _labelStyle;

  @override
  void initState() {
    super.initState();
    _content = widget.content;
    _maxLines = widget.maxLines ?? 3;
    _style = widget.style;
    _expandLabel = widget.expandLabel ?? '全文';
    _retractLabel = widget.retractLabel ?? '收起';
    _hasRetract = widget.hasRetract ?? false;
    _labelStyle = widget.labelStyle ??
        const TextStyle(
          fontSize: 15,
          color: Colors.blue,
        );
  }

  void _doExpansion() {
    setState(() {
      _isExpansion = !_isExpansion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  Widget _mainView() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 将 [TextSpan] 树绘制到 [Canvas] 中的对象。
        TextPainter textPainter = TextPainter(
          maxLines: _maxLines,
          text: TextSpan(text: _content, style: _style),
          textDirection: TextDirection.ltr,
        )..layout(
            // 设置宽度约束
            maxWidth: constraints.maxWidth,
          );

        List<Widget> ws = [];
        if (textPainter.didExceedMaxLines && _isExpansion == false) {
          // 不展开, 超出最大行数 (didExceedMaxLines检查是否超出高度)
          ws.add(
            Text(
              _content,
              maxLines: _maxLines,
              overflow: TextOverflow.ellipsis,
              style: _style,
            ),
          );
          ws.add(
            GestureDetector(
              onTap: _doExpansion,
              child: Text(_expandLabel!, style: _labelStyle),
            ),
          );
        } else {
          // 不展开, 未超出最大行数 || 已展开 => 显示全文 + 收起
          ws.add(Text(_content, style: _style));
          if (_hasRetract!) {
            ws.add(GestureDetector(
              onTap: _doExpansion,
              child: Text(_retractLabel!, style: _labelStyle),
            ));
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ws,
        );
      },
    );
  }
}
