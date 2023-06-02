import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:flutter_start/core/utils/index.dart';

class NewsAPI {
  // /// 分类
  // static Future<List<CategoryResponseEntity>> categories({
  //   bool cacheDisk = false,
  // }) async {
  //   var response = await HttpUtil().get('/categories');
  //   return response?.data
  //       .map<CategoryResponseEntity>(
  //         (item) => CategoryResponseEntity.fromJson(item),
  //       )
  //       .toList();
  // }
  //
  // /// 推荐
  // static Future<NewsItem> newsRecommend({
  //   NewsRecommendRequestEntity? params,
  //   bool refresh = false,
  //   bool cacheDisk = false,
  // }) async {
  //   var response = await HttpUtil().get(
  //     '/news/recommend',
  //     queryParameters: params?.toJson(),
  //     // refresh: refresh,
  //     // cacheDisk: cacheDisk,
  //   );
  //   return NewsItem.fromJson(response);
  // }
  //
  // /// 频道
  // static Future<List<ChannelResponseEntity>> channels({
  //   bool cacheDisk = false,
  // }) async {
  //   var response = await HttpUtil().get(
  //     '/channels',
  //   );
  //   return response
  //       .map<ChannelResponseEntity>(
  //         (item) => ChannelResponseEntity.fromJson(item),
  //       )
  //       .toList();
  // }

  /// 新闻列表
  static Future<NewsPageListResponseEntity> newsPageList({
    NewsPageListRequestEntity? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await HttpUtil().get(
      'https://mock.apifox.cn/m1/1124717-0-default/news',
      queryParameters: params?.toJson(),
      hasLoading: false,
      // refresh: refresh,
      // cacheDisk: cacheDisk,
      // cacheKey: STORAGE_INDEX_NEWS_CACHE_KEY,
    );
    LoggerUtil.debug("response::$response");
    return NewsPageListResponseEntity.fromJson(response?.data);
  }
}
