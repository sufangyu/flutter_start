import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/common/helpers/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 弹窗关闭的层级
enum CloseLevel {
  first,
  second,
}

/// 资源类型
enum PickType { camera, asset }

/// 拍摄类型
enum CaptureType { photo, video }

class PickerAssetBottomSheetHelper {
  PickerAssetBottomSheetHelper({required this.selectedAssets});

  /// 资源列表
  final List<AssetEntity>? selectedAssets;

  /// 微信类型
  Future<T?> wxPicker<T>(BuildContext context) {
    return BottomSheetWidget.show<T>(
      context,
      _buildPickAssets(context),
      bodyPadding: const EdgeInsets.all(0),
    );
  }

  // 弹出路由到顶层
  void _popRoute(
    BuildContext context, {
    required CloseLevel level,
    result,
  }) {
    if (level == CloseLevel.second) {
      Navigator.pop(context);
    }
    Navigator.pop(context, result);
  }

  /// 处理照片选择、拍摄
  _handlePickerPhoto(
    BuildContext context,
    PickType pickType,
    RequestType requestType,
  ) async {
    LoggerUtil.debug(
        "处理照片选择、拍摄::pickType->$pickType, requestType->$requestType");
    List<AssetEntity>? result;

    switch (pickType) {
      case PickType.camera:
        AssetEntity? asset = await PickerHelper.takePhoto(context);
        if (asset == null) {
          return;
        }
        result = _getTakeResult(asset, requestType);
        break;
      case PickType.asset:
        result = await PickerHelper.assets(
          context,
          selectedAssets: selectedAssets,
          maxAssets: 9,
        );
        break;
    }
    LoggerUtil.debug("处理照片选择、拍摄 result::$result");

    if (context.mounted) {
      _popRoute(context, level: CloseLevel.second, result: result);
    }
  }

  /// 处理视频选择、拍摄
  _handlePickerVideo(
    BuildContext context,
    PickType pickType,
    RequestType requestType,
  ) async {
    LoggerUtil.debug(
        "处理视频选择、拍摄::pickType->$pickType, requestType->$requestType");
    List<AssetEntity>? result;

    switch (pickType) {
      case PickType.camera:
        AssetEntity? asset = await PickerHelper.takeVideo(context);
        if (asset == null) {
          return;
        }
        result = _getTakeResult(asset, requestType);
        break;
      case PickType.asset:
        result = await PickerHelper.assets(
          context,
          selectedAssets: selectedAssets,
          requestType: RequestType.video,
          maxAssets: 1,
        );
        break;
    }
    LoggerUtil.debug("处理照片选择、拍摄 result::$result");
    if (context.mounted) {
      _popRoute(context, level: CloseLevel.second, result: result);
    }
  }

  /// 处理拍摄照片、视频返回结果
  List<AssetEntity> _getTakeResult(
    AssetEntity asset,
    RequestType requestType,
  ) {
    List<AssetEntity> result = [];
    if (requestType == RequestType.image) {
      result = selectedAssets != null ? [...selectedAssets!, asset] : [asset];
    } else if (requestType == RequestType.video) {
      result = [asset];
    }
    return result;
  }

  /// 选择资源类型
  Widget _buildPickAssets(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItem(
            onTap: () {
              BottomSheetWidget.show(
                context,
                _buildCaptureType(context, PickType.asset),
                bodyPadding: const EdgeInsets.all(0),
              );
            },
            children: [const Text("从相册选择")],
          ),
          const Divider(height: 1),
          _buildItem(
            onTap: () {
              BottomSheetWidget.show(
                context,
                _buildCaptureType(context, PickType.camera),
                bodyPadding: const EdgeInsets.all(0),
              );
            },
            children: [
              const Text("拍摄"),
              Text(
                "照片或视频",
                style: TextStyle(fontSize: 12.sp, color: Colors.black45),
              ),
            ],
          ),
          Divider(height: 8, thickness: 8, color: Colors.grey.withOpacity(0.1)),
          _buildItem(
            onTap: () => _popRoute(context, level: CloseLevel.first),
            children: [const Text("取消")],
          ),
        ],
      ),
    );
  }

  /// 选择相册资源、拍摄类型
  Widget _buildCaptureType(BuildContext context, PickType pickType) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItem(
            onTap: () =>
                _handlePickerPhoto(context, pickType, RequestType.image),
            children: [const Text("照片")],
          ),
          const Divider(height: 1),
          _buildItem(
            onTap: () =>
                _handlePickerVideo(context, pickType, RequestType.video),
            children: [const Text("视频")],
          ),
          Divider(height: 8, thickness: 8, color: Colors.grey.withOpacity(0.1)),
          _buildItem(
            onTap: () => _popRoute(context, level: CloseLevel.second),
            children: [const Text("取消")],
          ),
        ],
      ),
    );
  }

  /// bottomSheet item
  Widget _buildItem({
    required GestureTapCallback onTap,
    required List<Widget> children,
  }) {
    double itemHeight = 56.h;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: itemHeight,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
