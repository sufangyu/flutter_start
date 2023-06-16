import 'package:flutter/material.dart';

import 'index.dart';
import 'popup.config.dart';

/// 很重要，父组件通过这个 globalKey 调用组件的方法
GlobalKey<PopupWidgetState> popupKey = GlobalKey();

class PopupWidget extends StatefulWidget {
  const PopupWidget({
    Key? key,
    required this.child,
    this.position,
    this.width,
    this.height,
    this.round = false,
    this.title,
    this.closeable = false,
    this.closePosition,
    this.closeOnMaskClick = true,
    this.onClosed,
  }) : super(key: key);

  final Widget child;

  /// 弹窗位置
  final PopupPosition? position;

  /// 弹窗尺寸（宽、高）
  final double? width;
  final double? height;

  /// 是否显示圆角. 默认 false
  final bool? round;

  /// 标题
  final Widget? title;

  /// 是否显示关闭按钮. 默认 false
  final bool? closeable;

  /// 关闭弹窗位置
  final PopupClosePosition? closePosition;

  /// 是否点击背景蒙层后关闭. 默认 true
  final bool? closeOnMaskClick;

  /// 关闭弹窗回调函数
  final Function? onClosed;

  @override
  State<PopupWidget> createState() => PopupWidgetState();
}

class PopupWidgetState extends State<PopupWidget>
    with TickerProviderStateMixin {
  /// 出现位置
  late PopupPosition? _position;

  late PopupClosePosition? _closePosition;

  /// 弹窗尺寸（宽、高）
  late double? _width;
  late double? _height;

  /// 圆角
  late BorderRadiusGeometry? _borderRadius = borderRadiusZero;

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
  }

  /// 初始化内容状态（动画、圆角）
  void _initContentState() {
    _position = widget.position ?? PopupPosition.bottom;
    _closePosition = widget.closePosition ?? PopupClosePosition.topRight;

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
  }

  /// 关闭弹窗
  Future<void> onClose() async {
    if (_animController.status != AnimationStatus.completed) {
      return;
    }

    await _animController.reverse();

    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // 关闭回调
    widget.onClosed?.call();
  }

  /// 头部信息
  Widget _buildHeader() {
    if (widget.closeable == true || widget.title != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: (_closePosition == PopupClosePosition.topLeft ||
                _closePosition == PopupClosePosition.bottomLeft)
            ? TextDirection.rtl
            : null,
        children: [
          if (widget.closeable == true) _buildHeaderSides(),
          Expanded(
            child: Container(
              height: 42,
              alignment: Alignment.center,
              child: widget.title ?? const SizedBox.shrink(),
            ),
          ),
          if (widget.closeable == true) _buildHeaderCloseButton(),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  /// 头部关闭按钮
  Widget _buildHeaderCloseButton() {
    return GestureDetector(
      onTap: onClose,
      child: _buildHeaderSides(
        child: const Icon(Icons.close_rounded),
      ),
    );
  }

  /// 头部左右内容快
  Container _buildHeaderSides({Widget? child}) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8),
      height: 42,
      width: 42,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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

  /// 主体内容
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
          // crossAxisAlignment: CrossAxisAlignment.end,
          verticalDirection: (_closePosition == PopupClosePosition.bottomLeft ||
                  _closePosition == PopupClosePosition.bottomRight)
              ? VerticalDirection.up
              : VerticalDirection.down,
          children: [
            _buildHeader(),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
