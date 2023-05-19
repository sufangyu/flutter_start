class TimelineEntity {
  TimelineEntity({
    this.id,
    this.images,
    this.video,
    this.content,
    this.postType,
    this.user,
    this.publishDate,
    this.location,
    this.isLike,
    this.likes,
    this.comments,
  });
  late final String? id;
  late final List<String>? images;
  late final VideoEntity? video;
  late final String? content;
  late final String? postType;
  late final UserEntity? user;
  late final String? publishDate;
  late final String? location;
  late final bool? isLike;
  late final List<LikesEntity>? likes;
  late final List<CommentsEntity>? comments;

  TimelineEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = List.castFrom<dynamic, String>(json['images']);
    video = VideoEntity.fromJson(json['video']);
    content = json['content'];
    postType = json['post_type'];
    user = UserEntity.fromJson(json['user']);
    publishDate = json['publishDate'];
    location = json['location'];
    isLike = json['is_like'];
    likes =
        List.from(json['likes']).map((e) => LikesEntity.fromJson(e)).toList();
    comments = List.from(json['comments'])
        .map((e) => CommentsEntity.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['images'] = images;
    data['video'] = video?.toJson();
    data['content'] = content;
    data['post_type'] = postType;
    data['user'] = user?.toJson();
    data['publishDate'] = publishDate;
    data['location'] = location;
    data['is_like'] = isLike;
    data['likes'] = likes?.map((e) => e.toJson()).toList();
    data['comments'] = comments?.map((e) => e.toJson()).toList();
    return data;
  }
}

class VideoEntity {
  VideoEntity({
    this.cover,
    this.url,
  });
  late final String? cover;
  late final String? url;

  VideoEntity.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cover'] = cover;
    data['url'] = url;
    return data;
  }
}

class UserEntity {
  UserEntity({
    this.uid,
    this.nickname,
    this.avator,
    this.cover,
  });
  late final String? uid;
  late final String? nickname;
  late final String? avator;
  late final String? cover;

  UserEntity.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avator = json['avator'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['nickname'] = nickname;
    data['avator'] = avator;
    data['cover'] = avator;
    return data;
  }
}

class LikesEntity {
  LikesEntity({
    this.uid,
    this.nickname,
    this.avator,
  });
  late final String? uid;
  late final String? nickname;
  late final String? avator;

  LikesEntity.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avator = json['avator'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['nickname'] = nickname;
    data['avator'] = avator;
    return data;
  }
}

class CommentsEntity {
  CommentsEntity({
    this.user,
    this.content,
    this.publishDate,
  });
  late final UserEntity? user;
  late final String? content;
  late final String? publishDate;

  CommentsEntity.fromJson(Map<String, dynamic> json) {
    user = UserEntity.fromJson(json['user']);
    content = json['content'];
    publishDate = json['publishDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user?.toJson();
    data['content'] = content;
    data['publishDate'] = publishDate;
    return data;
  }
}
