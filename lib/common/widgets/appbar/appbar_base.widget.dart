import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

/// 自定义 appbar（支持动画）
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.leading,
    this.actions,
    this.isAnimated,
    this.isShow,
    this.title,
    this.height,
  }) : super(key: key);

  /// 背景色
  final Color? backgroundColor;

  /// 阴影扩散系数
  final double? elevation;

  /// 左侧内容
  final Widget? leading;

  /// 右侧区域
  final List<Widget>? actions;

  /// 是否动画
  final bool? isAnimated;

  /// 是否显示
  final bool? isShow;

  /// 标题
  final Widget? title;

  /// appbar 高度. 默认: 56.0
  final double? height;

  Widget _mainView() {
    AppBar appBar = AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      leading: leading,
      actions: actions,
      title: title,
    );

    Duration duration = const Duration(milliseconds: 300);

    return isAnimated == true
        ? isShow == true
            ? FadeInDown(duration: duration, child: appBar)
            : FadeOutUp(duration: duration, child: appBar)
        : appBar;
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  @override
  // Size get preferredSize => title?.preferredSize ?? const Size.fromHeight(56.0);
  Size get preferredSize => Size.fromHeight(height ?? 56.0);
}
