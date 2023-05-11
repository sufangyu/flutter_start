import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 弹窗显示位置
enum Placement {
  /// 居中
  center,

  /// 底部居中
  bottomCenter,
}

class DialogBase extends StatelessWidget {
  const DialogBase({
    super.key,
    this.title,
    required this.body,
    this.placement = Placement.center,
    this.maskColor,
    this.dialogColor = Colors.white,
    this.dialogRadius = 32.0,
    this.showClose = false,
    this.confirmText = "确认",
    this.onTap,
    this.actions,
  });

  /// 弹窗标题
  final String? title;

  /// 是否显示关闭按钮
  final bool? showClose;

  /// 弹窗主内容
  final Widget body;

  /// 弹窗显示位置
  final Placement? placement;

  /// 遮罩层颜色
  final Color? maskColor;

  /// 弹窗背景色
  final Color? dialogColor;

  /// 弹窗圆角
  final double? dialogRadius;

  /// 确定按钮文本
  final String confirmText;

  /// 确定按钮回调函数
  final void Function()? onTap;

  /// 自定义按钮组
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 遮罩层
        GestureDetector(
          onTap: () => _closeDialog(context),
          child: Container(
            color: maskColor ?? Colors.black.withOpacity(0.65),
            child: null,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          alignment: placement == Placement.bottomCenter
              ? Alignment.bottomCenter
              : Alignment.center,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(dialogRadius!)),
            clipBehavior: Clip.hardEdge,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
            // ),
            child: Container(
              color: dialogColor,
              padding: const EdgeInsets.all(24),
              child: Column(
                // 自适应内容高度
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 16),
                  // 主体内容
                  body,
                  const SizedBox(height: 32),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 渲染底部内容
  Widget _buildFooter(BuildContext context) {
    var actionList = actions;

    if (actions == null) {
      actionList = SizedBox(
        width: double.infinity,
        child: CupertinoButton.filled(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          onPressed: () {
            _closeDialog(context);
            if (onTap != null) {
              onTap!();
            }
          },
          child: Text(confirmText, style: const TextStyle(fontSize: 18)),
        ),
      );
    }

    return actionList!;
  }

  /// 渲染头部内容
  Widget _buildHeader(BuildContext context) {
    Widget head = title != null
        ? Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              showClose == true
                  ? Positioned(
                      right: 0,
                      top: -4,
                      child: InkWell(
                        onTap: () => _closeDialog(context),
                        child: const Icon(
                          Icons.close,
                          size: 28,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        : Container();
    return head;
  }

  /// 关闭弹窗
  _closeDialog(BuildContext context) {
    Navigator.of(context).pop("close");
  }
}
