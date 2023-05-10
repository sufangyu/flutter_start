import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'controller.dart';

class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  /// 顶部导航
  _buildAppBar({String? title}) {
    return transparentAppBar(
      title: Text(title ?? ''),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.primaryText,
        ),
        onPressed: () => Get.back(),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.bookmark_border,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            toastInfo(msg: "收藏未上线，请稍后");
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            color: AppColors.primaryText,
          ),
          onPressed: () async {
            final detail = controller.state.newsDetail;
            final result =
                await Share.shareWithResult("${detail?.title} ${detail?.url}");
            switch (result.status) {
              case ShareResultStatus.success:
                toastInfo(msg: "分享成功");
                break;
              case ShareResultStatus.dismissed:
                toastInfo(msg: "已取消分享");
                break;
              case ShareResultStatus.unavailable:
                toastInfo(msg: "未知错误");
                break;
              default:
            }
          },
        )
      ],
    );
  }

  /// 页面标题
  Widget _buildPageTitle() {
    return Container(
      margin: EdgeInsets.all(10.w),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 标题
              Obx(
                () => Text(
                  controller.state.newsDetail?.category ?? '',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    fontSize: 30.sp,
                    color: AppColors.thirdElement,
                  ),
                ),
              ),
              // 作者
              Obx(
                () => Text(
                  controller.state.newsDetail?.author ?? '',
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                    color: AppColors.thirdElementText,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // 标志
          CircleAvatar(
            radius: 22.w,
            backgroundImage: const AssetImage("assets/images/channel-fox.png"),
          ),
        ],
      ),
    );
  }

  /// 页面头部
  Widget _buildPageHeader() {
    return Container(
      margin: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 图
          netImageCached(
            controller.state.newsDetail?.thumbnail ?? '',
            width: 335.w,
            height: 200.h, // 290.h
          ),
          // 标题
          Container(
            margin: EdgeInsets.only(top: 10.w),
            child: Text(
              controller.state.newsDetail?.title ?? '',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
                fontSize: 24.sp,
                height: 1,
              ),
            ),
          ),
          // 一行 3 列
          Container(
            margin: EdgeInsets.only(top: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 分类
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Text(
                    controller.state.newsDetail?.category ?? '',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.normal,
                      color: AppColors.secondaryElementText,
                      fontSize: 14.sp,
                      height: 1,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                // 添加时间
                Container(width: 15.w),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 120,
                  ),
                  child: Text(
                    '• ${timeLineFormat(controller.state.newsDetail?.addtime)}',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.normal,
                      color: AppColors.thirdElementText,
                      fontSize: 14.sp,
                      height: 1,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Obx(
      () => SizedBox(
        height: controller.state.webViewHeight,
        child: WebViewWidget(controller: controller.webController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageTitle(),
                const Divider(height: 1),
                _buildPageHeader(),
                _buildWebView(),
              ],
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.center,
              child: controller.state.isPageFinished
                  ? Container()
                  : Text('正在加载中...', style: TextStyle(fontSize: 16.sp)),
            ),
          )
        ],
      ),
    );
  }
}
