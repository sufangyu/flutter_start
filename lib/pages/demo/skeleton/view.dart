import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import 'controller.dart';

class SkeletonPage extends GetView<SkeletonController> {
  const SkeletonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFf7f8fa),
      appBar: AppBar(
        title: const Text('Skeleton 骨架屏'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDemoHeader("线条"),
          _linesView(),
          const SizedBox(height: 30),
          //
          _buildDemoHeader("头像/图片"),
          _avatarsView(),
          const SizedBox(height: 30),
          //
          _buildDemoHeader("列表"),
          _listTilesView(),
          const SizedBox(height: 30),
          //
          _buildDemoHeader("文本段落"),
          _paragraphsView(),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.DEMO_SKELETON_LIST_VIEW),
            child: const Text("ListView — 默认示例"),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _linesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonLine(),
        SkeletonLine(
          style: SkeletonLineStyle(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        const SkeletonLine(
          style: SkeletonLineStyle(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            height: 11,
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            borderRadius: BorderRadius.circular(8),
            height: 18,
            randomLength: true, // 随机宽度
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            borderRadius: BorderRadius.circular(8),
            height: 18,
            randomLength: true, // 随机宽度
          ),
        ),
      ],
    );
  }

  Widget _avatarsView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SkeletonAvatar(),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            borderRadius: BorderRadius.circular(8),
            height: 62,
            width: 62,
          ),
        ),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(
            shape: BoxShape.circle,
            height: 72,
            width: 72,
          ),
        ),
        const SkeletonAvatar(
          style: SkeletonAvatarStyle(height: 96, width: 72),
        ),
      ],
    );
  }

  Widget _listTilesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonListTile(padding: const EdgeInsets.symmetric(vertical: 8)),
        const SizedBox(height: 8),
        SkeletonListTile(
          hasSubtitle: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        const SizedBox(height: 8),
        SkeletonListTile(
          hasSubtitle: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          leadingStyle: const SkeletonAvatarStyle(
            shape: BoxShape.circle,
            width: 64,
            height: 64,
          ),
          titleStyle: SkeletonLineStyle(
            borderRadius: BorderRadius.circular(16),
          ),
          subtitleStyle: SkeletonLineStyle(
            borderRadius: BorderRadius.circular(16),
            randomLength: true,
            maxLength: 128,
          ),
          verticalSpacing: 16,
        ),
        SkeletonListTile(
          hasSubtitle: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
          leadingStyle: const SkeletonAvatarStyle(
            shape: BoxShape.circle,
            width: 80,
            height: 80,
          ),
          titleStyle: const SkeletonLineStyle(height: 18),
          subtitleStyle: const SkeletonLineStyle(
            height: 12,
            maxLength: 172,
            minLength: 128,
          ),
          verticalSpacing: 16,
          contentSpacing: 6,
          trailing: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              height: 32,
              width: 50,
              borderRadius: BorderRadius.circular(4),
              padding: const EdgeInsetsDirectional.only(start: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _paragraphsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonParagraph(),
        const Divider(),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
            spacing: 6, // 间隙
            lineStyle: SkeletonLineStyle(
              height: 16,
              randomLength: true,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const Divider(),
        SkeletonParagraph(
          style: const SkeletonParagraphStyle(
            lines: 8,
            spacing: 6,
            lineStyle: SkeletonLineStyle(height: 12, randomLength: true),
          ),
        ),
        const Divider(),
        SkeletonParagraph(
          style: const SkeletonParagraphStyle(
            lines: 5,
            spacing: 8,
            lineStyle: SkeletonLineStyle(
              alignment: Alignment.topRight,
              height: 12,
              randomLength: true,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  /// 示例标题
  Widget _buildDemoHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Text(
        title,
        style: TextStyle(color: Colors.black54, fontSize: 16.sp),
      ),
    );
  }
}
