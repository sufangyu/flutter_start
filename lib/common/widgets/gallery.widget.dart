import 'package:chewie/chewie.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/style/text.style.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 预览类型
enum GalleryType { assets, urls, video }

class GalleryWidget extends StatefulWidget {
  /// 初始图片位置
  final int initialIndex;

  /// 图片列表
  final List<AssetEntity>? items;

  /// URL 图片列表
  final List<String>? imgUrls;

  /// 动态信息
  final TimelineEntity? timeline;

  ///  是否显示 bar
  final bool? isBarVisible;

  const GalleryWidget({
    Key? key,
    required this.initialIndex,
    this.items,
    this.imgUrls,
    this.timeline,
    this.isBarVisible,
  }) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver, RouteAware {
  /// 是否显示 bar
  bool _isShowAppBar = true;

  /// 预览类型
  GalleryType _galleryType = GalleryType.assets;

  /// 当前显示图片的序号
  int _curIndex = 0;

  /// video 视频控制器
  VideoPlayerController? _videoController;

  /// chewie 控制器
  ChewieController? _chewieController;

  final GlobalKey<ExtendedImageGestureState> gestureKey =
      GlobalKey<ExtendedImageGestureState>(debugLabel: "debugLabel1");

  @override
  void initState() {
    super.initState();
    // 初始化值
    _isShowAppBar = widget.isBarVisible ?? true;
    _curIndex = widget.initialIndex;
    _galleryType = _getGalleryType();

    // 将给定对象注册为绑定观察者. 捆绑 当各种应用程序事件发生时，观察者会收到通知
    // 例如: 当系统区域设置更改时、APP 生命周期
    WidgetsBinding.instance.addObserver(this);

    // 在下一帧之后调用回调。如果在帧绘制之前调用，则回调将在下一帧中调用。
    WidgetsBinding.instance.addPostFrameCallback((_) => _onLoadVideo());

    LoggerUtil.info("gestureKey::${gestureKey.currentState}");
  }

  @override
  void dispose() {
    super.dispose();
    LoggerUtil.error("gestureKey::${gestureKey.currentState}");
    // 取消路由订阅
    AppPages.observer.unsubscribe(this);
    gestureKey.currentState?.reset();

    _videoController?.dispose();
    _chewieController?.dispose();
    _videoController = null;
    _chewieController = null;
  }

  ////////////// 路由监听 start //////////////
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 订阅路由
    AppPages.observer.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPushNext() {
    super.didPushNext();
    if (_videoController?.value.isInitialized != true) {
      return;
    }
    _chewieController?.pause();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (_videoController?.value.isInitialized != true) {
      return;
    }
    _chewieController?.play();
  }
  ////////////// 路由监听 end //////////////

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 页面级别的APP生命周期的监听, 处理视频的暂停、播放
    super.didChangeAppLifecycleState(state);
    if (_videoController?.value.isInitialized != true) {
      return;
    }

    if (state == AppLifecycleState.resumed) {
      // 该应用程序是可见的并响应用户输入 => 播放
      _chewieController?.play();
    } else {
      // 任务栏、后台、销毁 => 暂停
      _chewieController?.pause();
    }
  }

  /// 获取 阅览类型
  GalleryType _getGalleryType() {
    if (widget.timeline?.postType == "2") {
      // 视频
      return GalleryType.video;
    } else if (widget.items != null) {
      // 发布选取的相册图片 AssetEntity
      return GalleryType.assets;
    } else if (widget.imgUrls != null) {
      // url 图片列表
      return GalleryType.urls;
    }
    return GalleryType.assets;
  }

  /// // 初始加载视频
  Future<void> _onLoadVideo() async {
    if (widget.timeline?.postType != "2") {
      return Future.value();
    }

    try {
      // video_player 初始化
      _videoController =
          VideoPlayerController.network(widget.timeline?.video?.url ?? "");
      // 尝试打开给定的 [dataSource] 并加载有关视频的元数据。
      await _videoController?.initialize();

      // chewie 初始化
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        autoInitialize: true,
        showOptions: false,
        // 用于 iOS 控件的颜色。默认情况下，iOS 播放器使用 从原始 iOS 11 设计中采样的颜色。
        cupertinoProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
        ),
        // 用于 material 进度条的颜色。默认情况下，材质播放器使用主题中的颜色。
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
        ),
        // 定义是否应显示播放速度控件
        allowPlaybackSpeedChanging: false,
        // 定义进入全屏时允许的设备方向集
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitUp,
        ],
        // 定义退出全屏后允许的设备方向集
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
        ],
        // 占位组件
        placeholder: _videoController?.value.isInitialized != true
            ? Image.network(
                widget.timeline?.video?.cover ?? "",
                fit: BoxFit.cover,
              )
            : null,
      );
    } catch (_) {
      Loading.error('Video url load error.');
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// 导航压入新界面, 测试视频播放是否停止
  /// TODO: 实际根据情况删除
  void _onTestPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text("新界面")),
            body: const Center(child: Text("新界面, 验证是否是否暂停")),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  Widget _mainView() {
    // 默认加载中
    Widget body = const Text("loading...");
    // 数量
    int itemsCount = widget.items?.length ?? widget.imgUrls?.length ?? 0;

    // 根据类型构建不同的 view
    switch (_galleryType) {
      case GalleryType.assets:
        body = _buildImageByAssetsView();
        break;
      case GalleryType.urls:
        body = _buildImageByUrlsView();
        break;
      case GalleryType.video:
        body = _buildVideoView();
        break;
    }

    return GestureDetector(
      onTap: () {
        _isShowAppBar = !_isShowAppBar;
        setState(() {});
      },
      behavior: HitTestBehavior.opaque, // 图片外区域点击不允许点透
      child: Scaffold(
        extendBodyBehindAppBar: true, // 是否延伸body至顶部
        backgroundColor: Colors.black,
        appBar: _galleryType == GalleryType.assets
            ? _buildPublishNav(itemsCount)
            : _buildPreviewNav(itemsCount),
        body: body,
        bottomSheet: _buildTimelineBar(_isShowAppBar),
      ),
    );
  }

  /// 导航栏 - 选相册
  AppBarWidget _buildPublishNav(int pages) {
    return AppBarWidget(
      isAnimated: true,
      isShow: _isShowAppBar,
      title: Text(
        "${_curIndex + 1} / $pages",
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 16),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              elevation: 0,
            ),
            child: const Text("发布"),
          ),
        ),
      ],
    );
  }

  /// 导航栏 - 图片 url 列表
  AppBarWidget _buildPreviewNav(int pages) {
    return AppBarWidget(
      isAnimated: true,
      isShow: _isShowAppBar,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 日期
          Text(
            widget.timeline?.publishDate ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          // 页码页数
          if (widget.timeline?.postType == "1")
            Text(
              "${_curIndex + 1}/$pages",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      actions: [
        GestureDetector(
          onTap: _onTestPage,
          child: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.more_horiz_outlined, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// 动态栏
  Widget? _buildTimelineBar(bool isShow) {
    // 基础数据
    TimelineEntity? timeline = widget.timeline;
    int likesCount = timeline?.likes?.length ?? 0;
    int commentsCount = timeline?.comments?.length ?? 0;

    if (isShow == false || timeline == null) {
      return null;
    }

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 内容
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(timeline.content ?? "", style: textStyleDetail),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10 * 3,
            ),
            child: Row(
              children: [
                // 喜欢
                const Icon(Icons.favorite_border_outlined,
                    size: 24, color: Colors.white),
                const SizedBox(width: 8),
                Text("$likesCount", style: textStyleDetail),
                const SizedBox(width: 24),
                // 评论
                const Icon(Icons.chat_bubble_outline,
                    size: 24, color: Colors.white),
                const SizedBox(width: 8),
                Text("评论($commentsCount)", style: textStyleDetail),
                const Spacer(),

                // 详情按钮
                GestureDetector(
                  onTap: () {},
                  child: Text("详情 >", style: textStyleDetail),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// URL 图片视图
  Widget _buildImageByUrlsView() {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
        pageSpacing: 8,
      ),
      onPageChanged: (int index) {
        _curIndex = index;
        setState(() {});
      },
      itemCount: widget.imgUrls?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final String src = widget.imgUrls![index];
        return ExtendedImage(
          image: ExtendedNetworkImageProvider(
            "$src?x-oss-process=image/resize,w_700",
          ),
          mode: ExtendedImageMode.gesture,
          fit: BoxFit.contain,
          initGestureConfigHandler: (state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true,
            );
          },
        );
      },
    );
  }

  /// 视频
  Widget _buildVideoView() {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.grey[900],
          alignment: Alignment.center,
          child: _chewieController == null
              ? Text("加载中...", style: textStyleDetail.copyWith())
              : Chewie(controller: _chewieController!),
        ),
      ),
    );
  }

  /// 本地图片资源
  Widget _buildImageByAssetsView() {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: _curIndex,
        pageSpacing: 8,
      ),
      itemCount: widget.items?.length,
      scrollDirection: Axis.horizontal,
      onPageChanged: (int index) {
        _curIndex = index;
        setState(() {});
      },
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity? item = widget.items?[index];

        // TODO: 双击放大；手势放大缩小
        return ExtendedImage(
          image: AssetEntityImageProvider(item!, isOriginal: true),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          enableLoadState: true,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return Icon(Icons.photo, color: Colors.teal.shade100);
              case LoadState.completed:
                // var widget = ExtendedRawImage(
                //   image: state.extendedImageInfo?.image,
                //   fit: BoxFit.cover,
                // );
                return null;
              case LoadState.failed:
                return Icon(Icons.photo, color: Colors.teal.shade100);
            }
          },
          initGestureConfigHandler: (state) {
            // return GestureConfig(
            //   minScale: 0.9,
            //   animationMinScale: 0.7,
            //   maxScale: 3.0,
            //   animationMaxScale: 3.5,
            //   speed: 1.0,
            //   inertialSpeed: 100.0,
            //   initialScale: 1.0,
            //   inPageView: true,
            //   initialAlignment: InitialAlignment.center,
            // );
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 4.0,
              animationMaxScale: 4.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: false,
              initialAlignment: InitialAlignment.center,
              reverseMousePointerScrollDirection: true,
              gestureDetailsIsChanged: (GestureDetails? details) {
                debugPrint(details?.totalScale.toString());
              },
            );
          },
          // onDoubleTap: (ExtendedImageGestureState state) {
          //   var pointerDownPosition = state.pointerDownPosition;
          //   double? begin = state.gestureDetails?.totalScale;
          //   double end;
          //
          //   // if (begin == doubleTapScales[0]) {
          //   //   end = doubleTapScales[1];
          //   // } else {
          //   //   end = doubleTapScales[0];
          //   // }
          //   // LoggerUtil.info("begin->$begin, end->$end");
          // },
          // enableSlideOutPage: true,
          // initGestureConfigHandler: (ExtendedImageState state) {
          //   return GestureConfig(
          //     minScale: 0.9,
          //     animationMinScale: 0.7,
          //     maxScale: 4.0,
          //     animationMaxScale: 4.5,
          //     speed: 1.0,
          //     inertialSpeed: 100.0,
          //     initialScale: 1.0,
          //     inPageView: false,
          //     initialAlignment: InitialAlignment.center,
          //     reverseMousePointerScrollDirection: true,
          //     gestureDetailsIsChanged: (GestureDetails? details) {
          //       print(details?.totalScale);
          //     },
          //   );
          // },
        );
      },
    );
  }
}
