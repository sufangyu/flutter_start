import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'controller.dart';
import 'state.dart';

// 间距
const double spacing = 10.0;

class WechatPostPage extends GetView<WechatPostController> {
  const WechatPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          // backgroundColor: Colors.red,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text("发表")),
            )
          ],
        ),
      ),
      body: _mainView(),
      bottomSheet: _buildRemoveBar(),
    );
  }

  Widget _mainView() {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 发表输入框
            _buildContentInput(),
            // 资源列表
            _buildAssetsList(),
            // 菜单项目
            _buildMenus(),
          ],
        ),
      ),
    );
  }

  /// 输出框
  Widget _buildContentInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: LimitedBox(
        maxHeight: 200,
        child: TextField(
          controller: controller.contentController,
          maxLength: 100,
          maxLines: null,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          decoration: const InputDecoration(
            hintText: '这一刻的想法...',
            hintStyle: TextStyle(
              color: Colors.black45,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            counterText: null,
          ),
        ),
      ),
    );
  }

  /// 菜单项目
  Widget _buildMenus() {
    List<Widget> ws = [];
    ws.add(const Divider(height: 1));

    for (var menu in controller.menus) {
      ws.add(ListTile(
        leading: Icon(menu.icon),
        title: Row(
          children: [
            Text(menu.title),
            if (menu.right != null) const Spacer(),
            if (menu.right != null)
              Text(menu.right!, style: const TextStyle(color: Colors.black45))
          ],
        ),
        trailing: const Icon(Icons.navigate_next_rounded),
        horizontalTitleGap: -5, // 标题与图标间距
      ));
      ws.add(const Divider(height: 1));
    }

    return Padding(
      padding: EdgeInsets.only(top: 100.h, left: 12.w, right: 12.w),
      child: Column(children: ws),
    );
  }

  /// 图片列表
  Widget _buildAssetsList() {
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          const spaceAll = spacing * 2;
          double paddingAll = controller.imagePadding * 2 * 3;
          double width = (constraints.maxWidth - spaceAll - paddingAll) / 3;

          return Obx(
            () => Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: _getAssetsList(width),
            ),
          );
        },
      ),
    );
  }

  /// 获取资源列表
  _getAssetsList(double width) {
    switch (controller.state.postType) {
      case PostType.image:
        return _buildPhotosLayout(width);
      case PostType.video:
        return _buildVideoLayout(width);
      default:
    }
  }

  /// 图片列表
  List<Widget> _buildPhotosLayout(double width) {
    List<Widget> children = [];

    // 图片列表
    children = controller.state.selectedAssets
        .map((asset) => _buildPhotoItem(asset, width))
        .toList();

    // 显示添加按钮（图片: 未超出最大张数限制）
    LoggerUtil.debug(
        "${controller.state.selectedAssets.length} < ${controller.maxAssets}");
    if (controller.state.selectedAssets.length < controller.maxAssets) {
      children.add(_buildAddBtn(width));
    }

    return children;
  }

  /// 选择图片资源的 item
  Widget _buildPhotoItem(AssetEntity asset, double width) {
    return Draggable<AssetEntity>(
      // 拖拽的数据
      data: asset,
      // 拖动进行时显示在指针下方的小部件
      feedback: _buildImageItem(asset: asset, width: width),
      // 当正在拖动时原位置占位组件
      childWhenDragging: _buildImageItem(
        asset: asset,
        width: width,
        opacity: 0.3,
      ),

      // 当可拖动对象开始被拖动时调用。
      onDragStarted: () => controller.state.isDragNow = true,
      // 当可拖动对象被放下时调用。
      onDragEnd: (DraggableDetails details) {
        controller.state.isDragNow = false;
        controller.state.isWillSort = false;
      },
      // 当 draggable 被放置并被 [DragTarget] 接受时调用。
      onDragCompleted: () {},
      // 当 draggable 被放置但未被 [DragTarget] 接受时调用。
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        controller.state.isDragNow = false;
        controller.state.isWillSort = false;
      },

      child: DragTarget<AssetEntity>(
        builder: (BuildContext context, List candidateData, List rejectedData) {
          return GestureDetector(
            onTap: () {
              // 预览图片
              Navigator.push(
                Get.context!,
                MaterialPageRoute(builder: (context) {
                  return GalleryWidget(
                    initialIndex:
                        controller.state.selectedAssets.indexOf(asset),
                    items: controller.state.selectedAssets,
                  );
                }),
              );
            },
            child: _buildImageItem(asset: asset, width: width),
          );
        },
        onWillAccept: (data) => controller.handleWillAcceptSort(data!, asset),
        onAccept: (data) => controller.handleAcceptSort(data, asset),
        onLeave: (data) => controller.resetOrderState(),
      ),
    );
  }

  /// 删除 bar 区域
  Widget _buildRemoveBar() {
    return Obx(() {
      return controller.state.isDragNow
          ? DragTarget<AssetEntity>(
              // 调用以确定此小部件是否有兴趣接收给定的 被拖动到这个拖动目标上的数据片段。
              onWillAccept: (data) {
                controller.state.isWillRemove = true;
                return true;
              },
              // 当被拖动到该目标上的给定数据离开时调用 目标。
              onLeave: (data) {
                controller.state.isWillRemove = false;
              },
              // 当一条可接受的数据被拖放到这个拖动目标上时调用。
              onAccept: (AssetEntity data) {
                controller.state.selectedAssets.remove(data);
                controller.state.isWillRemove = false;
              },

              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: double.infinity,
                  height: 120.h,
                  color: controller.state.isWillRemove
                      ? Colors.red[500]
                      : Colors.red[300],
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Icon(
                        Icons.delete,
                        color: controller.state.isWillRemove
                            ? Colors.white
                            : Colors.white70,
                        size: 32,
                      ),
                      Text(
                        "拖拽到这里删除",
                        style: TextStyle(
                          color: controller.state.isWillRemove
                              ? Colors.white
                              : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : const SizedBox.shrink();
    });
  }

  /// 视频播放器
  List<Widget> _buildVideoLayout(double width) {
    List<Widget> children = [];
    children.toList();
    bool hasVideo = controller.state.selectedAssets.isEmpty;

    if (!hasVideo) {
      // 播放器
      children.add(
        VideoPlayerPreviewWidget(
          initAsset: controller.state.selectedAssets.first,
          onCompleted: (value) => controller.state.videoCompressFile = value,
        ),
      );
    } else {
      // 添加按钮
      children.add(_buildAddBtn(width));
    }

    return children;
  }

  /// 图片内容
  Container _buildImageItem({
    required AssetEntity asset,
    required double width,
    double? opacity = 1,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: (controller.state.isWillSort &&
              controller.state.targetAssetId == asset.id)
          ? EdgeInsets.zero
          : const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: (controller.state.isWillSort &&
                controller.state.targetAssetId == asset.id)
            ? Border.all(
                color: controller.accentColor,
                width: controller.imagePadding,
              )
            : null,
      ),
      child: AssetEntityImage(
        asset,
        width: width,
        height: width,
        fit: BoxFit.cover,
        isOriginal: false,
        opacity: AlwaysStoppedAnimation(opacity!),
      ),
    );
  }

  Widget _buildAddBtn(double width) {
    return GestureDetector(
      onTap: controller.handlePickAssets,
      child: Container(
        color: Colors.black.withOpacity(0.08),
        width: width,
        height: width,
        child: const Icon(Icons.add_rounded, size: 48, color: Colors.black38),
      ),
    );
  }
}
