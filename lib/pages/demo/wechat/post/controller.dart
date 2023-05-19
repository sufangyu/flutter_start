import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/helpers/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:flutter_start/pages/demo/wechat/post/entity.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'state.dart';

class WechatPostController extends GetxController {
  /// 最多可选图片张数
  int maxAssets = 9;

  /// 视频录制最大时间 秒
  double maxVideoDuration = 30;

  /// 高亮色
  Color accentColor = Colors.blue;
  double imagePadding = 2;

  // 状态
  WechatPostState state = WechatPostState();

  // 内容输入控制器
  TextEditingController contentController = TextEditingController();

  /// 菜单项
  List<MenuItemEntity> menus = [];

  @override
  void onInit() {
    super.onInit();

    menus = [
      MenuItemEntity(icon: Icons.location_on_outlined, title: "所在位置"),
      MenuItemEntity(icon: Icons.alternate_email_outlined, title: "提醒谁看"),
      MenuItemEntity(icon: Icons.person_outline, title: "谁可以看", right: "公开"),
    ];

    state.postType = Get.arguments["postType"];
    state.selectedAssets = Get.arguments["selectedAssets"] ?? [];
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    if (state.selectedAssets.isEmpty && contentController.text.isEmpty) {
      return true;
    }

    // 有内容提示是否有退出
    return await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: const Text("保留此处编辑"),
          actions: <Widget>[
            CupertinoButton(
              child: const Text("不保留"),
              onPressed: () => Navigator.pop(context, true),
            ),
            CupertinoButton(
              child: const Text("保留"),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }

  /// 选择图片资源
  void handlePickAssets() async {
    PermissionUtil.checkPermission(
      permissions: [
        Permission.photos,
        Permission.camera,
        Permission.microphone,
        Permission.location
      ],
      onSuccess: () async {
        final result = await PickerAssetBottomSheetHelper(
          selectedAssets: state.selectedAssets,
        ).wxPicker<List<AssetEntity>>(Get.context!);

        if (result == null || result.isEmpty) {
          return;
        }

        if (result.length == 1 && result.first.type == AssetType.video) {
          // 视频
          state.postType = PostType.video;
          state.selectedAssets = result;
        } else {
          // 图片
          state.postType = PostType.image;
          state.selectedAssets = result;
        }
      },
    );
  }

  /// 处理是否可以拖拽排序
  bool handleWillAcceptSort(AssetEntity dragData, AssetEntity curAsset) {
    // 其他 item 才触发可拖拽
    if (dragData.id == curAsset.id) {
      return false;
    }

    state.isWillSort = true;
    state.targetAssetId = curAsset.id;
    return true;
  }

  /// 处理拖拽排序
  /// [dragData] 被拖拽元素
  /// [curAsset] 当前目标 item 元素
  void handleAcceptSort(AssetEntity dragData, AssetEntity curAsset) {
    // 1. 当前目标元素位置
    int targetIndex =
        state.selectedAssets.indexWhere((item) => item.id == curAsset.id);
    // 2. 删除原来的（被拖拽元素）
    state.selectedAssets.removeWhere((item) => item.id == dragData.id);
    // 3. 插入到目标前面
    state.selectedAssets.insert(targetIndex, dragData);
    // 4. 重置状态
    resetOrderState();
  }

  void resetOrderState() {
    state.isWillSort = false;
    state.targetAssetId = "";
  }
}
