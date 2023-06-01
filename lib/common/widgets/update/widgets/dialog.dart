import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enum.dart';

/// APP 弹窗 UI
class AppUpdateDialog extends StatefulWidget {
  /// 是否强制升级
  final bool isForce;

  /// 点击背景是否消失
  final bool isBackDismiss;

  /// 最新版本号
  final String version;

  /// 更新描述
  final String upgradeText;

  /// store 地址
  final String shopUrl;

  /// apk 地址
  final String fileUrl;

  const AppUpdateDialog({
    Key? key,
    required this.isForce,
    required this.isBackDismiss,
    required this.version,
    required this.upgradeText,
    required this.shopUrl,
    required this.fileUrl,
  }) : super(key: key);

  @override
  State<AppUpdateDialog> createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  /// 当前状态
  InstallStatus _installStatus = InstallStatus.normal;

  /// 当前进度
  late int _progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 54 透明度的黑色 0~255 0完全透明 255 不透明
      backgroundColor: Colors.black54,
      body: Material(
        type: MaterialType.transparency,
        // 监听Android设备上的返回键盘物理按钮
        child: WillPopScope(
          onWillPop: () {
            _closeUpdateDialog(context);
            // 返回true表示不拦截; 返回false拦截事件的向上传递
            return Future.value(true);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // LoggerUtil.info("APP更新::点击了背景");
                  if (!widget.isForce && widget.isBackDismiss) {
                    // 非强制更新 + 设置点击背景可以消失
                    _closeUpdateDialog(context);
                  }
                },
              ),
              _buildBodyContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 升级主内容区域
  SizedBox _buildBodyContainer(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 320.w,
                height: 370.h,
                padding: EdgeInsets.only(
                  top: 120.h,
                  left: 20.w,
                  bottom: 0,
                  right: 20.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.w)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "发现新版本（v${widget.version}）",
                      style: TextStyle(fontSize: 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 130.h,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.upgradeText,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildUpdateButton(context),
                  ],
                ),
              ),
              Positioned(
                top: 10.h,
                left: (170.w - 50.w),
                child: Image.asset(
                  "assets/images/ic_upgrade.png",
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ],
          ),
          SizedBox(height: widget.isForce ? 0 : 16.h),
          // 强更新不显示
          widget.isForce ? Container() : _buildCloseButton(context),
        ],
      ),
    );
  }

  /// 关闭按钮
  GestureDetector _buildCloseButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // LoggerUtil.info("APP更新::点击了关闭按钮");
        _closeUpdateDialog(context);
      },
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          color: Colors.white,
          size: 24.0,
        ),
      ),
    );
  }

  /// 更新按钮
  Stack _buildUpdateButton(BuildContext context) {
    return Stack(
      children: [
        // 实际按钮部分
        GestureDetector(
          onTap: () {
            _onTapUpdateButton(context);
          },
          child: Container(
            width: 300.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(40.w),
            ),
            child: Text(
              _buildUpdateButtonText(_progress),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ),
        // 结合 Align 实现的裁剪动画
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            // widthFactor: snapshot.data,
            widthFactor: _progress / 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40.h,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        )
      ],
    );
  }

  /// 更新按钮的文本内容
  /// 根据状态返回
  String _buildUpdateButtonText(int progress) {
    String buttonText = "";
    switch (_installStatus) {
      case InstallStatus.normal:
        buttonText = InstallStatus.normal.label;
        break;
      case InstallStatus.downing:
        buttonText = "下载中 $_progress%";
        break;
      case InstallStatus.downFinish:
        buttonText = "${InstallStatus.downFinish.label}，点击安装";
        break;
      case InstallStatus.downFail:
        buttonText = InstallStatus.downFail.label;
        break;
      case InstallStatus.installFail:
        buttonText = InstallStatus.installFail.label;
        break;
    }
    return buttonText;
  }

  /// 处理更新按钮的逻辑
  Future<void> _onTapUpdateButton(BuildContext context) async {
    if (Platform.isIOS) {
      // LoggerUtil.info("APP更新::跳转App Store::${widget.shopUrl}");

      Uri url = Uri.parse(widget.shopUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw "Could not launch $url";
      }
      return;
    }

    String localPath = await _getLocalPath();
    String fullPath = "$localPath/release-${widget.version}.apk";

    // 安卓逻辑
    if (_installStatus == InstallStatus.normal ||
        _installStatus == InstallStatus.downFail) {
      toastInfo(msg: '开始下载升级包');
      _installStatus = InstallStatus.downing;
      setState(() {});
      _downApkFunction(fullPath);
    } else if (_installStatus == InstallStatus.downFinish ||
        _installStatus == InstallStatus.installFail) {
      // 下载完成时 || 安装失败时 => 点触发安装
      _installApkFunction(fullPath);

      // fix: Don't use 'BuildContext's across async gaps
      if (context.mounted) {
        _closeUpdateDialog(context);
      }
    }
  }

  /// 下载 APK 包
  _downApkFunction(String fullPath) async {
    // LoggerUtil.info("Download app fullPath::$fullPath");

    // 下载 APK
    Dio dio = Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) => status! < 500,
      ),
    );

    // 404: https://lf9-apk.ugapk.cn/package/apk/jj_app/2632_64401/jj_app_download_app_normal_v2632_64401_277e_1679897332.apk?v=1679897334
    // 200:
    var uri =
        "https://lf9-apk.ugapk.cn/package/apk/jj_app/2632_64700/jj_app_download_app_normal_v2632_64700_3a55_1685343635.apk?v=1685343637";
    var response = await dio.get(
      uri,
      onReceiveProgress: (int count, int total) {
        // 安装包 404 也会触发, 用响应体大小处理下
        if (total <= 200) {
          _installStatus = InstallStatus.normal;
          _progress = 0;
          setState(() {});
          return;
        }
        int progress = ((count / total) * 100).toInt();
        _progress = progress;
        setState(() {});
      },
    );

    if (response.statusCode! >= 400) {
      // LoadingUtil.error("下载失败(${response.statusCode} ${response.statusMessage})");
      return;
    }

    // 保存文件
    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    // 完成下载: 设置相关状态, 安装 APP
    _installStatus = InstallStatus.downFinish;
    _progress = 0;
    setState(() {});
    _installApkFunction(fullPath);
  }

  /// 安装 APK 包
  _installApkFunction(String fullPath) async {
    OpenResult result = await OpenFile.open(fullPath);
    // LoggerUtil.debug("installApk result::${result.message}, $fullPath");

    // 没有权限则复制至临时目录进行打开安装
    if (result.message.toUpperCase().contains('MANAGE_EXTERNAL_STORAGE') ||
        result.message.toUpperCase().contains('READ_EXTERNAL_STORAGE')) {
      final filename = fullPath.split('/').last;
      var newPath = '${(await getTemporaryDirectory()).path}/$filename';
      await File(fullPath).copy(newPath);
      result = await OpenFile.open(newPath);

      // LoggerUtil.debug("兜底安装处理 result::${result.message}, $fullPath");
    }
  }

  /// 关闭更新弹窗
  void _closeUpdateDialog(BuildContext context) {
    // LoggerUtil.info("APP更新::关闭弹窗, 是否强更(${widget.isForce})");
    // 如果是强制升级 点击物理返回键退出应用程序
    if (widget.isForce) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      Navigator.of(context).pop();
    }
  }

  /// 获取存储路径
  // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
  // 如果是android，使用getExternalStorageDirectory
  // 如果是iOS，使用getApplicationSupportDirectory
  Future<String> _getLocalPath() async {
    final Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    if (directory == null) {
      throw "Could not get directory";
    } else {
      return directory.path;
    }
  }
}
