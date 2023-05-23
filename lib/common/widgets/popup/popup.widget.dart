import 'package:flutter/material.dart';

import 'index.dart';

// https://juejin.cn/post/7185921201204625463
// TODO: https://blog.csdn.net/a526001650a/article/details/127654284?ydreferer=aHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS8%3D

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    Key? key,
    required this.onClose,
    required this.child,
    this.position,
    this.width,
    this.height,
    this.closeOnMaskClick = true,
    this.round = false,
    this.closeable = false,
  }) : super(key: key);

  final Function() onClose;
  final Widget child;

  /// 弹窗位置
  final PopupPosition? position;

  /// 弹窗尺寸（宽、高）
  final double? width;
  final double? height;

  /// 是否点击背景蒙层后关闭. 默认 true
  final bool? closeOnMaskClick;

  /// 是否显示圆角. 默认 false
  final bool? round;

  /// 是否显示关闭按钮. 默认 false
  final bool? closeable;

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget>
    with TickerProviderStateMixin {
  /// 出现位置
  late PopupPosition? _position;

  /// 弹窗尺寸（宽、高）
  late double? _width;
  late double? _height;

  /// 圆角
  late BorderRadiusGeometry? _borderRadius =
      const BorderRadius.all(Radius.zero);

  /// 安全区域的是否设置上下安全间距
  late bool _safeAreaTop = true;
  late bool _safeAreaBottom = true;

  // 遮罩层动画
  static const _fadeInDuration = Duration(milliseconds: 250);
  static const _fadeOutDuration = Duration(milliseconds: 300);
  late final AnimationController _opacityController = AnimationController(
    vsync: this,
    duration: _fadeInDuration,
    reverseDuration: _fadeOutDuration,
  );

  // 主内容动画
  late final AnimationController _slideController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<Offset> _animation;
  late Tween<Offset> _tween;
  late Alignment _alignment;
  late Offset _begin;
  late Offset _end;

  @override
  void initState() {
    super.initState();
    _position = widget.position ?? PopupPosition.bottom;

    _initContentState();

    _slideController.forward();
    _opacityController.forward();
  }

  /// 初始化内容状态（动画、圆角）
  void _initContentState() {
    switch (_position!) {
      case PopupPosition.top:
        _alignment = Alignment.topLeft;
        _begin = const Offset(0.0, -1.0);
        _end = const Offset(0.0, 0.0);
        _width = double.infinity;
        _height = widget.height ?? 460;
        _safeAreaBottom = false;

        if (widget.round == true) {
          _borderRadius = const BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          );
        }
        break;
      case PopupPosition.bottom:
        _alignment = Alignment.bottomLeft;
        _begin = const Offset(0.0, 1.0);
        _end = const Offset(0.0, 0.0);
        _width = double.infinity;
        _height = widget.height ?? 460;
        _safeAreaTop = false;

        if (widget.round == true) {
          _borderRadius = const BorderRadius.only(
            topRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
          );
        }
        break;
      case PopupPosition.right:
        _alignment = Alignment.topRight;
        _begin = const Offset(1.0, 0.0);
        _end = const Offset(0.0, 0.0);
        _width = widget.width ?? 320;
        _height = double.infinity;
        break;
      case PopupPosition.left:
        _alignment = Alignment.topLeft;
        _begin = const Offset(-1.0, 0.0);
        _end = const Offset(0.0, 0.0);
        _width = widget.width ?? 320;
        _height = double.infinity;
        break;
    }

    _tween = Tween(begin: _begin, end: _end);
    _animation = _tween.animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _opacityController.dispose();
    _slideController.dispose();
  }

  /// 关闭弹窗
  Future<void> onClose() async {
    await _slideController.reverse();
    await _opacityController.reverse();
    widget.onClose();
  }

  /// 关闭按钮
  Widget _buildCloseButton() {
    return widget.closeable == true
        ? GestureDetector(
            onTap: onClose,
            child: Container(
              height: 42,
              width: 42,
              margin: const EdgeInsets.only(right: 8, top: 8),
              alignment: Alignment.center,
              child: const Icon(Icons.close_rounded),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            if (widget.closeOnMaskClick != true) {
              return;
            }
            onClose();
          },
          child: FadeTransition(
            opacity: _opacityController,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(.45),
            ),
          ),
        ),
        SlideTransition(
          position: _animation,
          child: Container(
            alignment: _alignment,
            child: Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: _borderRadius,
              ),
              child: SafeArea(
                top: _safeAreaTop,
                bottom: _safeAreaBottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildCloseButton(),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
