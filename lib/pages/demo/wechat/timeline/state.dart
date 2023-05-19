import 'package:flutter/material.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/pages/demo/wechat/post/index.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'entity.dart';

class WechatTimelineState {
  /// 已选择图片列表
  final RxList<AssetEntity> _selectedAssets = <AssetEntity>[].obs;
  List<AssetEntity> get selectedAssets => _selectedAssets;
  set selectedAssets(List<AssetEntity> value) => _selectedAssets.value = value;

  /// 发布类型
  PostType? postType = PostType.video;

  /// 用户资料
  UserEntity? user;

  /// 朋友圈
  final RxList<TimelineEntity> _timeline = <TimelineEntity>[].obs;
  List<TimelineEntity> get timeline => _timeline ?? [];
  set timeline(List<TimelineEntity> value) => _timeline.value = value;

  /// 是否显示 appbar 信息
  final RxBool _showAppBar = false.obs;
  bool get showAppBar => _showAppBar.value;
  set showAppBar(bool value) => _showAppBar.value = value;

  /// appbar 背景色
  final Rx<Color> _appBarColor = Colors.transparent.obs;
  Color get appBarColor => _appBarColor.value;
  set appBarColor(Color value) => _appBarColor.value = value;

  /// 点赞、评论弹出位置
  final Rx<Offset> _offset = Offset.zero.obs;
  Offset get offset => _offset.value;
  set offset(Offset value) => _offset.value = value;

  /// 当前操作的 item（点赞、评论）
  final Rx<TimelineEntity> _currentItem = TimelineEntity().obs;
  TimelineEntity get currentItem => _currentItem.value;
  set currentItem(TimelineEntity value) => _currentItem.value = value;

  /// 是否显示评论输入框
  final RxBool _isShowInput = false.obs;
  bool get isShowInput => _isShowInput.value;
  set isShowInput(bool value) => _isShowInput.value = value;

  /// 是否展开表情列表
  final RxBool _isShowEmoji = false.obs;
  bool get isShowEmoji => _isShowEmoji.value;
  set isShowEmoji(bool value) => _isShowEmoji.value = value;

  /// 是否有输入内容
  final RxBool _isInputWords = false.obs;
  bool get isInputWords => _isInputWords.value;
  set isInputWords(bool value) => _isInputWords.value = value;
}
