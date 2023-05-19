import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_start/common/apis/index.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/helpers/index.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:flutter_start/pages/demo/wechat/post/index.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'state.dart';
import 'widgets/like_comment.dart';

class WechatTimelineController extends GetxController
    with GetTickerProviderStateMixin {
  // 状态
  WechatTimelineState state = WechatTimelineState();

  // 滚动控制器
  final ScrollController scrollController = ScrollController();

  //
  late LikeComment _shadeOverlayEntry;

  // 动画控制器
  late AnimationController animationController;
  // 动画 tween
  late Animation<double> sizeTween;

  // 评论输入框
  final TextEditingController commentEditingController =
      TextEditingController();
  // 输入框焦点
  final FocusNode focusNode = FocusNode();
  // 键盘高度
  final double keyboardHeight = 200;

  @override
  onInit() {
    super.onInit();

    // 初始化动画控制器
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // 设置动画取值范围
    sizeTween = Tween(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    // 监控输入
    commentEditingController.addListener(() {
      state.isInputWords = commentEditingController.text.isNotEmpty;
    });

    // 模拟用户信息
    state.user = UserEntity(
      nickname: "方雨_Yu",
      avator: "https://avatars.githubusercontent.com/u/1852629?v=4",
      cover:
          "https://ducafecat.oss-cn-beijing.aliyuncs.com/podcast/2023/05/86ef77e134684cca73ee6bdc603dcafd.jpeg",
    );

    _loadData();
    _listenerScroll();
  }

  @override
  void onClose() {
    super.onClose();

    scrollController.dispose();
    animationController.dispose();
    commentEditingController.dispose();
    focusNode.dispose();
  }

  /// 载入数据
  Future _loadData() async {
    List<TimelineEntity> result = await WechatAPI.timelineNew();
    // LoggerUtil.debug("_loadData result::${result}");
    state.timeline = result;
  }

  /// 监听滚动距离
  void _listenerScroll() {
    scrollController.addListener(() {
      double distanceY = scrollController.position.pixels;
      int triggerY = 200;

      if (distanceY > triggerY) {
        // 透明度系数
        double opacity = min((distanceY - triggerY) / 100, 1.0);
        state.showAppBar = true;
        state.appBarColor = const Color(0xFFe0e0e0).withOpacity(opacity);
      } else {
        state.showAppBar = false;
        state.appBarColor = Colors.transparent;
      }
    });
  }

  /// 选择资源发表动态
  Future<void> post() async {
    final result = await PickerAssetBottomSheetHelper(
      selectedAssets: state.selectedAssets,
    ).wxPicker<List<AssetEntity>>(Get.context!);

    LoggerUtil.info("发布结果result::$result");

    if (result == null || result.isEmpty) {
      return;
    }

    Get.toNamed(
      AppRoutes.DEMO_WECHAT_ASSETS_PICKER,
      arguments: {
        "postType": (result.length == 1 && result.first.type == AssetType.video)
            ? PostType.video
            : PostType.image,
        "selectedAssets": result,
      },
    );
  }

  /// 显示点赞、点评
  Future<void> showLikeMenu(
    GlobalKey iKey, {
    required builder,
    required TimelineEntity item,
  }) async {
    state.currentItem = item;

    // 获取组件屏幕位置
    Offset offset = UiUtils.getOffset(iKey);
    state.offset = offset;

    _shadeOverlayEntry = LikeComment();
    _shadeOverlayEntry.showMenu(
      Get.context!,
      controller: animationController,
      onTap: onCloseLikeMenu,
      body: builder,
    );

    // 延迟显示菜单
    Future.delayed(const Duration(milliseconds: 100), () {
      if (animationController.status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  /// 关闭点赞、点评
  Future<void> onCloseLikeMenu() async {
    if (animationController.status == AnimationStatus.completed) {
      await animationController.reverse();
      _shadeOverlayEntry.onCloseMenu();
    }
  }

  /// 处理点赞
  void onLike(TimelineEntity item) {
    if (item.id == null) {
      return;
    }

    WechatAPI.like(item.id!);
  }

  /// 切换评论输入栏
  void onSwitchCommentBar() {
    state.isShowInput = !state.isShowInput;
    state.isShowEmoji = false;
    commentEditingController.text = "";

    // 是否获取输入焦点
    if (state.isShowInput) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
    }
  }

  /// 切换品评论输入类型
  void onSwitchInputType() {
    state.isShowEmoji = !state.isShowEmoji;
    if (state.isShowEmoji) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
  }

  /// 处理评论
  void onComment() {
    if (!state.isInputWords) {
      toastInfo(msg: "评论不能为空");
      return;
    }

    // add 数据 (需要复制副本, add 数据后再重新复制, 才能更新页面)
    List<TimelineEntity> newList = List.from(state.timeline);
    int index = newList.indexOf(state.currentItem);
    newList[index].comments?.add(
          CommentsEntity(
            content: commentEditingController.text,
            user: state.user,
            publishDate: DateTime.now().toString(),
          ),
        );
    state.timeline = newList;

    // 执行请求 异步处理
    WechatAPI.comment(state.currentItem.id!, commentEditingController.text);

    // 关闭
    onSwitchCommentBar();
  }

  void onGallery({TimelineEntity? item, String? src}) {
    Navigator.push(Get.context!, MaterialPageRoute(builder: (context) {
      // 视频、相册
      return GalleryWidget(
        initialIndex: src == null ? 1 : item?.images?.indexOf(src) ?? 1,
        timeline: item,
        imgUrls: item?.images ?? [],
      );
    }));
  }
}
