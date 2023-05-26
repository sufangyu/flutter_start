import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import 'controller.dart';

class SkeletonListViewPage extends GetView<SkeletonController> {
  const SkeletonListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFf7f8fa),
      appBar: AppBar(
        title: const Text('骨架屏-listView'),
      ),
      body: Obx(() {
        return Skeleton(
          isLoading: !controller.state.defaultFlag,
          skeleton: SkeletonListView(),
          child: _contentView(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.state.defaultFlag = !controller.state.defaultFlag;
        },
        child: Obx(() {
          return Icon(
            controller.state.defaultFlag
                ? Icons.hourglass_full
                : Icons.hourglass_bottom,
          );
        }),
      ),
    );
  }

  Widget _contentView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 80,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              color: Colors.black12,
              margin: const EdgeInsets.only(right: 8),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "用于在内容加载过程中展示一组占位图形。用于在内容加载过程中展示一组占位图形。",
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text("这是副标题、描述/简述文案"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
