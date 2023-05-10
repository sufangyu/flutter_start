import 'package:flutter_start/common/entities/index.dart';
import 'package:get/get.dart';

class DetailState {
  /// 新闻详情
  final _newsDetail = Rx<NewsItem?>(null);
  set newsDetail(NewsItem? value) => _newsDetail.value = value;
  NewsItem? get newsDetail => _newsDetail.value;

  /// Webview
  final _isPageFinished = false.obs;
  set isPageFinished(bool value) => _isPageFinished.value = value;
  bool get isPageFinished => _isPageFinished.value;
  final _webViewHeight = 800.0.obs;
  set webViewHeight(double value) => _webViewHeight.value = value;
  double get webViewHeight => _webViewHeight.value;
}
