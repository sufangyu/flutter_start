import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/styles/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:flutter_start/pages/demo/wechat/timeline/index.dart';
import 'package:get/get.dart';

class TimelineContent extends GetView<WechatTimelineController> {
  const TimelineContent({super.key});

  @override
  Widget build(BuildContext context) {
    List<TimelineEntity> timeline = controller.state.timeline;

    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: timeline.length,
          (BuildContext context, int index) {
            TimelineEntity item = timeline[index];
            return Column(
              children: [
                // 正文、图片、视频
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: _buildContent(item),
                ),
                // 点赞列表
                _buildLikeList(item),
                // 评论列表
                _buildCommentList(item),
                const Divider(),
              ],
            );
          },
        ),
      );
    });
  }

  // 点赞列表
  Widget _buildLikeList(TimelineEntity item) {
    return Container(
      margin: EdgeInsets.only(left: 60.w, right: 8.w, top: 8.w),
      padding: EdgeInsets.all(8.w),
      color: Colors.grey[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: const Icon(
              Icons.favorite_border_outlined,
              size: 20,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: [
                for (LikesEntity link in item.likes ?? [])
                  Image.network(
                    link.avator ?? "",
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentList(TimelineEntity item) {
    return Container(
      margin: EdgeInsets.only(left: 60.w, right: 8.w, top: 8.w),
      padding: EdgeInsets.all(8.w),
      color: Colors.grey[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 20,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                for (CommentsEntity comment in item.comments ?? [])
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 头像
                      Image.network(
                        comment.user?.avator ?? "",
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8.w),
                      // 昵称、时间、内容
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 昵称&时间
                            Row(
                              children: [
                                Text(comment.user?.nickname ?? "",
                                    style: textStyleComment.copyWith()),
                                const Spacer(),
                                Text(
                                  DateUtil.fromNow(comment.publishDate ?? ""),
                                  style: textStyleComment.copyWith(),
                                ),
                              ],
                            ),
                            // 内容
                            Text(
                              comment.content ?? "",
                              style: textStyleComment.copyWith(),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(TimelineEntity item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 圆角头像
        ClipRRect(
          borderRadius: BorderRadius.circular(4.w),
          child: Image.network(
            item.user?.avator ?? "",
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10.w),

        //  右侧
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              _buildNickname(item),
              SizedBox(height: 10.h),
              //
              _buildTextContent(item),
              SizedBox(height: 10.h),
              //
              _buildGridAndVideo(item),
              SizedBox(height: 10.h),
              //
              _buildLocation(item),
              SizedBox(height: 10.h),
              //
              _buildCreateTime(item),
            ],
          ),
        ),
      ],
    );
  }

  /// 昵称
  Widget _buildNickname(TimelineEntity item) {
    return Text(
      item.user?.nickname ?? "",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  /// 文本内容
  Widget _buildTextContent(TimelineEntity item) {
    return TextMaxLinesWidget(
      content: item.content ?? "",
      // maxLines: null,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black54,
      ),
    );
  }

  /// 位置信息
  Widget _buildLocation(TimelineEntity item) {
    return Text(
      item.location ?? "",
      style: const TextStyle(fontSize: 15, color: Colors.black54),
    );
  }

  /// 创建时间
  Widget _buildCreateTime(TimelineEntity item) {
    // 定义 globalKey 用于查询组件位置
    GlobalKey iKey = GlobalKey();

    return Row(
      children: [
        Text(
          item.publishDate ?? "",
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            controller.showLikeMenu(
              iKey,
              item: item,
              builder: AnimatedBuilder(
                animation: controller.animationController,
                builder: (BuildContext context, Widget? child) {
                  return Obx(
                    () {
                      return Positioned(
                        left: controller.state.offset.dx -
                            10 -
                            controller.sizeTween.value,
                        top: controller.state.offset.dy - 10,
                        child: SizedBox(
                          width: controller.sizeTween.value,
                          child: _buildIsLikeMenu(item),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
          child: Container(
            key: iKey,
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: const Icon(Icons.more_horiz_outlined),
          ),
        ),
      ],
    );
  }

  /// 喜欢、评论
  Widget _buildIsLikeMenu(TimelineEntity item) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black87,
        backgroundBlendMode: BlendMode.darken,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (constraints.maxWidth > 100)
                TextButton.icon(
                  onPressed: () {
                    controller.onCloseLikeMenu();
                    controller.onLike(item);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color:
                        item.isLike == true ? Colors.redAccent : Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    item.isLike == true ? "取消" : "喜欢",
                    style: textStylePopMenu.copyWith(),
                  ),
                ),
              if (constraints.maxWidth > 150)
                TextButton.icon(
                  onPressed: () {
                    controller.onCloseLikeMenu();
                    // 显示评论栏
                    controller.onSwitchCommentBar();
                  },
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text("评论", style: textStylePopMenu.copyWith()),
                ),
            ],
          );
        },
      ),
    );
  }

  /// 图片(九宫格)、视频
  Widget _buildGridAndVideo(TimelineEntity item) {
    // 视频
    if (item.postType == "2") {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double videoWidth = constraints.maxWidth * 0.7;
          return GestureDetector(
            onTap: () => controller.onGallery(item: item),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  item.video!.cover!,
                  height: videoWidth,
                  width: videoWidth,
                  fit: BoxFit.cover,
                ),
                // 播放图标
                Icon(Icons.play_circle, color: Colors.white, size: 48.sp),
              ],
            ),
          );
        },
      );
    }

    // 9宫格图片
    if (item.postType == "1") {
      int imgCount = item.images?.length ?? 0;
      // 图片间的间距
      double spacing = 10;

      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double imgWidth;
          if (imgCount == 1) {
            imgWidth = constraints.maxWidth * 0.7;
          } else if (imgCount == 2) {
            imgWidth = (constraints.maxWidth - spacing) / 2;
          } else {
            imgWidth = (constraints.maxWidth - spacing * 2) / 3;
          }

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (var imgUrl in item.images ?? [])
                GestureDetector(
                  onTap: () => controller.onGallery(src: imgUrl, item: item),
                  child: Image.network(
                    "$imgUrl?x-oss-process=image/resize,w_150",
                    height: imgWidth,
                    width: imgWidth,
                    fit: BoxFit.cover,
                    // loadingBuilder: (context, Widget child, loadingProgress) {
                    //   return Container(
                    //     color: Colors.black12,
                    //     height: imgWidth,
                    //     width: imgWidth,
                    //   );
                    // },
                  ),
                ),
            ],
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
