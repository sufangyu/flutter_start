import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_start/core/utils/index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

GlobalKey repaintWidgetKey = GlobalKey();

class CardShare {
  static OverlayEntry? overlayEntry;

  /// 显示
  static show(
    BuildContext context,
  ) {
    LoggerUtil.debug("CardShare show");

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: close,
            child: Container(color: Colors.black.withOpacity(0.65)),
          ),
          const ShareMainContent(onRemove: close),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  /// 关闭
  static close() async {
    // await popupKey.currentState?.onClose();
    overlayEntry?.remove();
    overlayEntry = null;
  }
}

class ShareMainContent extends StatelessWidget {
  const ShareMainContent({
    Key? key,
    required this.onRemove,
  }) : super(key: key);

  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Column(
      children: [
        const Expanded(
          child: CardShareContent(),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShareItem(
                      label: '保存图片',
                      onTap: () async => await _onSaveImage(context),
                    ),
                    const ShareItem(label: '微信'),
                    const ShareItem(label: '朋友圈'),
                    const ShareItem(label: 'QQ'),
                    const ShareItem(label: 'QQ空间'),
                    const ShareItem(label: '微博'),
                    const ShareItem(label: '钉钉'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: onRemove, child: const Text("取消")),
              ),
              SizedBox(height: bottomPadding),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onSaveImage(BuildContext context) async {
    // 截屏图片生成图片流 ByteData
    ByteData? byteData =
        await ImageUtil.capturePngToByteData(context, repaintWidgetKey);
    LoggerUtil.debug("byteData::$byteData");

    // 申请权限后, 保存图片到相册
    PermissionUtil.checkPermission(
      permissions: [Permission.camera],
      onSuccess: () async {
        File? file = await ImageUtil.saveImageToCamera(byteData!);
        LoggerUtil.debug("path::$file");

        LoadingUtil.success("保存成功");
        onRemove();
      },
    );
  }
}

/// 分享的内容
class CardShareContent extends StatelessWidget {
  const CardShareContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(top: topPadding, bottom: 24, left: 24, right: 24),
      child: RepaintBoundary(
        key: repaintWidgetKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFffffff),
            // border: Border.all(color: Colors.black38, width: 1),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.black38.withOpacity(0.1),
                child: const Center(child: Text("APP LOGO 部分")),
              ),
              const SizedBox(height: 16),
              const Row(children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("作者名称"), Text("2023-01-01")],
                )
              ]),
              const SizedBox(height: 16),
              const Text(
                "🚀芜湖，埋点还可以这么做？这也太简单了",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                "随着项目的不断完善，需要向外推广app，微信分享就是一个很常用的方式，我们常用webPage分享，这次我们扩展为图片截图并分享到朋友圈，效果图如下：",
                style: TextStyle(fontSize: 16),
              ),
              const Divider(height: 48),
              Row(children: [
                QrImageView(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 100.0,
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("长按识别二维码"), Text("进入 APP 阅读全文")],
                )
              ]),
              // Container(height: 100, color: Colors.yellow),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareItem extends StatelessWidget {
  const ShareItem({
    Key? key,
    required this.label,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final String label;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
            width: 64,
            height: 64,
            color: Colors.blue.withOpacity(0.1),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
