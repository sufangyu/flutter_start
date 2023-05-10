class ChannelResponseEntity {
  ChannelResponseEntity({
    required this.code,
    required this.title,
  });
  late final String code;
  late final String title;

  ChannelResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['title'] = title;
    return data;
  }
}
