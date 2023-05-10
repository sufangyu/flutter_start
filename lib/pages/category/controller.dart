import 'package:flutter_start/common/apis/index.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

class CategoryController extends GetxController {
  CategoryController();

  /// 响应式成员变量 =========================================
  final state = CategoryState();

  /// 成员变量 =========================================
  String categoryCode = '';
  int curPage = 1;
  int pageSize = 10;
  int total = 100;

  /// UI 组件 =========================================
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  /// 事件 =========================================
  onRefresh() {
    fetchNewsList(isRefresh: true).then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  onLoading() {
    if (state.newsList.length < total) {
      fetchNewsList().then((_) {
        refreshController.loadComplete();
      }).catchError((_) {
        refreshController.loadFailed();
      });
    } else {
      refreshController.loadNoData();
    }
  }

  /// 方法 =========================================
  // 拉取数据
  Future<void> fetchNewsList({bool isRefresh = false}) async {
    var result = await NewsAPI.newsPageList(
      params: NewsPageListRequestEntity(
        categoryCode: categoryCode,
        pageNum: curPage + 1,
        pageSize: pageSize,
      ),
    );

    LoggerUtil.debug("result::${result.items}");

    if (isRefresh == true) {
      curPage = 1;
      total = result.counts!;
      state.newsList.clear();
    } else {
      curPage++;
    }

    state.newsList.addAll(result.items!);
  }

  /// 生命周期 =========================================
  @override
  void dispose() {
    super.dispose();
    // dispose 释放对象
    refreshController.dispose();
  }
}
