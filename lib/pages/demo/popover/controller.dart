import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import 'state.dart';

class DemoPopoverController extends GetxController {
  DemoPopoverState state = DemoPopoverState();

  /// 生命周期 -------------------------------------------

  /// 静态数据、普通函数 -----------------------------------

  /// 显示 popover.
  /// 注意: context 需要与页面与组件的分开, 可以用 StatelessWidget 封装触发的点击区域
  void showPopoverWindow({
    required BuildContext context,
    required Widget body,
  }) {
    showPopover(
      context: context,
      bodyBuilder: (ctx) => body,
      onPop: () => LoggerUtil.info('Popover was popped!'),
      transition: PopoverTransition.scale,
      backgroundColor: Colors.white,
      width: 200,
      height: 340,
      arrowHeight: 8,
      arrowWidth: 16,
    );
  }
}
