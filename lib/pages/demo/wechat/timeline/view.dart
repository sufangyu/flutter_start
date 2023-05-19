import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/header.dart';
import 'widgets/timeline.dart';

class WechatTimelinePage extends GetView<WechatTimelineController> {
  const WechatTimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 内容扩展到状态栏,与应用栏的顶部对齐
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Obx(() => _buildAppBar()),
      ),
      body: _mainView(context),
      bottomNavigationBar: Obx(() {
        return controller.state.isShowInput
            ? _buildCommentBar(context)
            : const SizedBox.shrink();
      }),
    );
  }

  /// appbar
  AppBar _buildAppBar() {
    WechatTimelineState state = controller.state;
    return AppBar(
      backgroundColor: state.appBarColor,
      elevation: 0,
      title: Text(state.showAppBar ? '朋友圈' : ''),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: GestureDetector(
            onTap: controller.post,
            child: Icon(
              Icons.camera_alt,
              color: state.showAppBar ? Colors.black45 : Colors.white,
            ),
          ),
        )
      ],
    );
  }

  /// 评论内容框
  Widget _buildCommentBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      // 撑起输入框
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCommentBarText(),
            // 微信表情列表 (根据条件)
            _buildCommentBarEmoji(),
          ],
        ),
      ),
    );
  }

  // 评论输入框
  Widget _buildCommentBarText() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.commentEditingController,
            focusNode: controller.focusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              // 圆角边框
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "评论",
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
                letterSpacing: 2,
              ),
            ),
            maxLines: 1,
            minLines: 1,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: controller.onSwitchInputType,
          child: Icon(
            controller.state.isShowEmoji
                ? Icons.keyboard_alt_outlined
                : Icons.mood_outlined,
            size: 32,
            color: Colors.black54,
          ),
        ),
        SizedBox(width: 10.w),
        ElevatedButton(
          onPressed:
              controller.state.isInputWords ? controller.onComment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            elevation: 0,
          ),
          child: const Text("发送", style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  /// 表情选择输入
  Widget _buildCommentBarEmoji() {
    return !controller.state.isShowEmoji
        ? const SizedBox.shrink()
        : Container(
            height: controller.keyboardHeight,
            padding: EdgeInsets.all(8.w),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 横轴上的组件数量
                mainAxisSpacing: 10, // 沿主轴的组件之间的逻辑像素数。
                crossAxisSpacing: 10, // 沿横轴的组件之间的逻辑像素数。
              ),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Container(color: Colors.grey[300]);
              },
            ),
          );
  }

  Widget _mainView(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails e) {
        if (controller.state.isShowInput) {
          controller.onSwitchCommentBar();
        }
      },
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: const [
          SliverToBoxAdapter(child: TimelineHeader()),
          TimelineContent(),
        ],
      ),
    );
  }
}
