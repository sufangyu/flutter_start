/// 新闻列表 返回值
class NewsPageListResponseEntity {
  int? counts;
  int? pagesize;
  int? pages;
  int? page;
  List<NewsItem>? items;

  NewsPageListResponseEntity(
      {this.counts, this.pagesize, this.pages, this.page, this.items});

  NewsPageListResponseEntity.fromJson(Map<String, dynamic> json) {
    counts = json['counts'];
    pagesize = json['pagesize'];
    pages = json['pages'];
    page = json['page'];
    if (json['items'] != null) {
      items = <NewsItem>[];
      json['items'].forEach((v) {
        items!.add(NewsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counts'] = counts;
    data['pagesize'] = pagesize;
    data['pages'] = pages;
    data['page'] = page;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 新闻列表请求参数
class NewsPageListRequestEntity {
  /// 分类 code
  String? categoryCode;
  String? channelCode;
  String? tag;
  String? keyword;
  int? pageNum;
  int? pageSize;

  NewsPageListRequestEntity({
    this.categoryCode,
    this.channelCode,
    this.tag,
    this.keyword,
    this.pageNum,
    this.pageSize,
  });

  NewsPageListRequestEntity.fromJson(Map<String, dynamic> json) {
    categoryCode = json['categoryCode'];
    channelCode = json['channelCode'];
    tag = json['tag'];
    keyword = json['keyword'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryCode'] = categoryCode;
    data['channelCode'] = channelCode;
    data['tag'] = tag;
    data['keyword'] = keyword;
    data['pageNum'] = pageNum;
    data['pageSize'] = pageSize;
    return data;
  }
}

/// 新闻单项
class NewsItem {
  NewsItem({
    this.id,
    this.title,
    this.category,
    this.thumbnail,
    this.author,
    this.addtime,
    this.url,
  });

  late final String? id;
  late final String? title;
  late final String? category;
  late final String? thumbnail;
  late final String? author;
  late final DateTime? addtime;
  late final String? url;

  NewsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    author = json['author'];
    addtime = DateTime.parse(json["addtime"]);
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['author'] = author;
    data['addtime'] = addtime?.toIso8601String();
    data['url'] = url;
    return data;
  }
}

/// 新闻推荐 request
class NewsRecommendRequestEntity {
  NewsRecommendRequestEntity({
    this.categoryCode,
    this.channelCode,
    this.tag,
    this.keyword,
  });
  late final String? categoryCode;
  late final String? channelCode;
  late final String? tag;
  late final String? keyword;

  NewsRecommendRequestEntity.fromJson(Map<String, dynamic> json) {
    categoryCode = json['categoryCode'];
    channelCode = json['channelCode'];
    tag = json['tag'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categoryCode'] = categoryCode;
    data['channelCode'] = channelCode;
    data['tag'] = tag;
    data['keyword'] = keyword;
    return data;
  }
}
