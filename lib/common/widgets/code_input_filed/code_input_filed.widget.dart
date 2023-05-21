import 'package:flutter/material.dart';

import 'model.dart';
import 'widget/input_cell.widget.dart';

class CodeInputFiled extends StatefulWidget {
  const CodeInputFiled({
    Key? key,
    this.code,
    this.length,
    this.type,
    this.onChanged,
  }) : super(key: key);

  // 已经输入验证码
  final String? code;

  /// 验证码个数（框）
  final int? length;

  /// 输入框样式
  final CodeInputType? type;

  /// 输入值回调函数
  final void Function(String val)? onChanged;

  @override
  State<CodeInputFiled> createState() => _CodeInputFiledState();
}

class _CodeInputFiledState extends State<CodeInputFiled> {
  // 验证码个数（框）
  late int _length;
  // 输入框样式
  late CodeInputType _type;

  // 输入框
  final TextEditingController _controller = TextEditingController(text: '');
  // 输入框值
  String _code = '';

  @override
  void initState() {
    super.initState();

    _length = widget.length ?? 6;
    _type = widget.type ?? CodeInputType.squareBox;
  }

  Widget _buildInputOpacity() {
    return Opacity(
      opacity: 0,
      child: TextField(
        controller: _controller,
        maxLength: _length,
        maxLines: 1,
        //只能输入字母与数字
        // inputFormatters: [
        //   WhitelistingTextInputFormatter(RegExp("[a-z,0-9,A-Z]"))
        // ],
        autofocus: true,
        keyboardType: TextInputType.number,
        onChanged: (String val) {
          _code = val;
          setState(() {});

          // 输入完成执行回调
          if (val.length >= _length && widget.onChanged != null) {
            widget.onChanged!(val);
          }
        },
        decoration: const InputDecoration(
          // border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cells = <Widget>[];
    for (int i = 1; i <= _length; i++) {
      cells.add(
        InputCell(
          isFocused: _code.length == i - 1,
          text: _code.length >= i ? _code.substring(i - 1, i) : '',
          type: _type,
        ),
      );
    }

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cells,
        ),
        _buildInputOpacity(),
      ],
    );
  }
}
