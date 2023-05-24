import 'package:flutter/material.dart';

import 'index.dart';
import 'popup.config.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    Key? key,
    required this.onCloseOverlay,
    required this.child,
    this.position,
    this.width,
    this.height,
    this.closeOnMaskClick = true,
    this.round = false,
    this.closeable = false,
    this.onClosed,
  }) : super(key: key);

  final Function() onCloseOverlay;
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

  /// 关闭弹窗回调函数
  final Function? onClosed;

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
  late BorderRadiusGeometry? _borderRadius = borderRadiusZero;

  // 遮罩层动画
  late final AnimationController _opacityController = AnimationController(
    vsync: this,
    duration: inDuration,
    reverseDuration: outDuration,
  );

  late final AnimationController _animController = AnimationController(
    duration: inDuration,
    reverseDuration: outDuration,
    vsync: this,
  );
  late final CurvedAnimation _curveAnimation = CurvedAnimation(
    parent: _animController,
    curve: Curves.easeInOut,
  );
  late Animation<double> _contentAnimation; // 用于保存动画的过渡值和状态

  @override
  void initState() {
    super.initState();

    _initContentState();
    _animController.forward();
    _opacityController.forward();
  }

  /// 初始化内容状态（动画、圆角）
  void _initContentState() {
    _position = widget.position ?? PopupPosition.bottom;

    switch (_position!) {
      case PopupPosition.top:
        _height = widget.height ?? defaultHeight;
        _contentAnimation =
            Tween(begin: -_height!, end: 0.0).animate(_curveAnimation);

        if (widget.round == true) {
          _borderRadius = borderRadiusBottom;
        }
        break;
      case PopupPosition.bottom:
        _height = widget.height ?? defaultHeight;
        _contentAnimation =
            Tween(begin: -_height!, end: 0.0).animate(_curveAnimation);

        if (widget.round == true) {
          _borderRadius = borderRadiusTop;
        }
        break;
      case PopupPosition.right:
        _width = widget.width ?? defaultWidth;
        _contentAnimation =
            Tween(begin: -_width!, end: 0.0).animate(_curveAnimation);
        break;
      case PopupPosition.left:
        _width = widget.width ?? defaultWidth;
        _contentAnimation =
            Tween(begin: -_width!, end: 0.0).animate(_curveAnimation);
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
    _opacityController.dispose();
  }

  /// 关闭弹窗
  Future<void> onClose() async {
    if (_animController.status != AnimationStatus.completed ||
        _opacityController.status != AnimationStatus.completed) {
      return;
    }
    await _animController.reverse();
    await _opacityController.reverse();
    widget.onCloseOverlay();

    if (widget.onClosed != null) {
      widget.onClosed!();
    }
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
        // 遮罩层
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
        AnimatedBuilder(
          animation: _animController,
          builder: (BuildContext ctx, child) {
            return _buildContentWrapper(); // 通过animation.value值的改变产生动画效果
          },
        ),
      ],
    );
  }

  /// 主体内容容器（负责动画）
  Widget _buildContentWrapper() {
    final size = MediaQuery.of(context).size;
    switch (_position!) {
      case PopupPosition.top:
        return Positioned(
          top: _contentAnimation.value,
          child: _buildContent(
            width: size.width,
            height: _height!,
            safeAreaBottom: false,
          ),
        );
      case PopupPosition.bottom:
        return Positioned(
          bottom: _contentAnimation.value,
          child: _buildContent(
            width: size.width,
            height: _height!,
            safeAreaTop: false,
          ),
        );
      case PopupPosition.right:
        return Positioned(
          right: _contentAnimation.value,
          child: _buildContent(width: _width!, height: size.height),
        );
      case PopupPosition.left:
        return Positioned(
          left: _contentAnimation.value,
          child: _buildContent(width: _width!, height: size.height),
        );
    }
  }

  Container _buildContent({
    required double width,
    required double height,
    bool? safeAreaTop = true,
    bool? safeAreaBottom = true,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _borderRadius,
      ),
      // child: widget.child,
      child: SafeArea(
        top: safeAreaTop!,
        bottom: safeAreaBottom!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildCloseButton(),
            widget.child,
          ],
        ),
      ),
    );
  }
}
