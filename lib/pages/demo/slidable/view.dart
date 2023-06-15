import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DemoSlidablePage extends GetView<DemoSlidableController> {
  const DemoSlidablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('侧滑菜单'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    List<Widget> ws = [];
    for (var i = 0; i < 5; i++) {
      ws.add(
        Slidable(
          key: ValueKey(i),
          groupTag: "todo", // this must be unique
          direction: Axis.horizontal,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                padding: const EdgeInsets.symmetric(vertical: 4),
                onPressed: (_) => controller.doNothing('DELETE', i),
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '删除',
              ),
              SlidableAction(
                onPressed: (_) => controller.doNothing('SHARE', i),
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: '分享',
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.8, // 宽度比
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (_) => controller.doNothing('ARCHIVE', i),
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: '存档',
              ),
              SlidableAction(
                flex: 1,
                padding: EdgeInsets.zero,
                onPressed: (_) => controller.doNothing('SAVE', i),
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: '保存',
              ),
            ],
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black12,
            height: 72,
            child: Text('左右滑动看效果（$i）'),
          ),
        ),
      );

      if (i != 5 - 1) {
        ws.add(const SizedBox(height: 4));
      }
    }
    // SlidableAutoCloseBehavior 控制一次只能有一个
    return SlidableAutoCloseBehavior(
      child: Column(
        children: ws,
      ),
    );
  }
}
