/// get 请求参数
class RequestReqEntity {
  RequestReqEntity({
    required this.size,
    required this.page,
    this.keyword,
  });
  late final int size;
  late final int page;
  String? keyword;

  RequestReqEntity.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['size'] = size;
    data['page'] = page;
    data['keyword'] = keyword;
    return data;
  }
}

/// get 响应值
class RequestResEntity {
  RequestResEntity({
    this.age,
    this.name,
  });
  late final int? age;
  late final String? name;

  RequestResEntity.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['age'] = age;
    data['name'] = name;
    return data;
  }
}

/// post
class ArticleReqEntity {
  ArticleReqEntity({
    required this.title,
    required this.category,
    required this.content,
  });
  late final String title;
  late final String category;
  late final String content;

  ArticleReqEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['category'] = category;
    data['content'] = content;
    return data;
  }
}

/// post 响应
class ArticleResEntity {
  ArticleResEntity({
    this.id,
    this.title,
    this.category,
    this.content,
    this.author,
    this.createdAt,
  });
  late final String? id;
  late final String? title;
  late final String? category;
  late final String? content;
  late final String? author;
  late final String? createdAt;

  ArticleResEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    content = json['content'];
    author = json['author'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['content'] = content;
    data['author'] = author;
    data['created_at'] = createdAt;
    return data;
  }
}
