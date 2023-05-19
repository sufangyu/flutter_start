import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PickerHelper {
  /// 相册选取（图片、视频）
  /// [selectedAssets] 资源集合
  /// [maxAssets] 最多可选资源个数. 默认 9 张
  /// [requestType] 选择资源类型. 默认图片
  static Future<List<AssetEntity>?> assets(
    BuildContext context, {
    List<AssetEntity>? selectedAssets,
    int maxAssets = 9,
    RequestType requestType = RequestType.image, // 默认图片
    double maxVideoDuration = 30, // 视频最大时长(秒)
  }) async {
    List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: selectedAssets,
        requestType: requestType,
        maxAssets: maxAssets,
        filterOptions: FilterOptionGroup(
          videoOption: FilterOption(
            durationConstraint: requestType == RequestType.video
                ? DurationConstraint(
                    max: Duration(seconds: maxVideoDuration.toInt()),
                  )
                : const DurationConstraint(),
          ),
        ),
      ),
    );
    return result;
  }

  /// 拍图片
  static Future<AssetEntity?> takePhoto(BuildContext context) async {
    final result = await Navigator.of(context).push<AssetEntity?>(
      MaterialPageRoute(
        builder: (context) {
          return const CameraPage(captureMode: CaptureMode.photo);
        },
      ),
    );
    return result;
  }

  /// 拍视频
  static Future<AssetEntity?> takeVideo(
    BuildContext context, {
    Duration maxVideoDuration = const Duration(seconds: 30),
  }) async {
    final result = await Navigator.of(context).push<AssetEntity?>(
      MaterialPageRoute(
        builder: (context) {
          return CameraPage(
            captureMode: CaptureMode.video,
            maxVideoDuration: maxVideoDuration,
          );
        },
      ),
    );
    return result;
  }
}
