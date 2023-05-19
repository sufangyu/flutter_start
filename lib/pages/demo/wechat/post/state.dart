import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum PostType { image, video }

class WechatPostState {
  /// 已选择图片列表
  final RxList<AssetEntity> _selectedAssets = <AssetEntity>[].obs;
  List<AssetEntity> get selectedAssets => _selectedAssets;
  set selectedAssets(List<AssetEntity> value) => _selectedAssets.value = value;

  /// 是否开始拖拽
  final _isDragNow = false.obs;
  bool get isDragNow => _isDragNow.value;
  set isDragNow(bool value) => _isDragNow.value = value;

  /// 是否将要删除
  final _isWillRemove = false.obs;
  bool get isWillRemove => _isWillRemove.value;
  set isWillRemove(bool value) => _isWillRemove.value = value;

  /// 是否将要排序
  final _isWillSort = false.obs;
  bool get isWillSort => _isWillSort.value;
  set isWillSort(bool value) => _isWillSort.value = value;

  /// 拖拽至目标元素的 id
  final _targetAssetId = "".obs;
  String get targetAssetId => _targetAssetId.value;
  set targetAssetId(String value) => _targetAssetId.value = value;

  /// 发布类型
  PostType? postType = PostType.video;

  /// 视频压缩文件
  CompressMediaFile? videoCompressFile;
}
