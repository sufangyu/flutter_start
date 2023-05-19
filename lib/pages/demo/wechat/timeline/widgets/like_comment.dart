import 'package:flutter/material.dart';

class LikeComment {
  late OverlayEntry _shadeOverlayEntry;

  /// 显示遮罩层菜单
  showMenu(
    BuildContext context, {
    required Widget body,
    AnimationController? controller,
    Function()? onTap,
  }) {
    OverlayState overlayState = Overlay.of(context);

    _shadeOverlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          left: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () async {
              if (onTap != null) {
                onTap();
              }
            },
            child: Stack(
              children: [
                // 背景色渐变动画
                AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  duration: const Duration(milliseconds: 300),
                  color: Colors.black.withOpacity(0.6),
                  curve: Curves.fastOutSlowIn,
                ),
                body,
              ],
            ),
          ),
        );
      },
    );

    overlayState.insert(_shadeOverlayEntry);
  }

  /// 关闭遮罩层菜单
  void onCloseMenu() {
    _shadeOverlayEntry.remove();
    _shadeOverlayEntry.dispose();
  }
}
