/// 基础响应体
class BaseResponseEntity<T> {
  BaseResponseEntity({
    this.code,
    this.success,
    this.message,
    this.data,
  });
  late final int? code;
  late final bool? success;
  late final String? message;
  late final T? data;

  BaseResponseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }

  @override
  String toString() {
    return data.toString();
  }
}

/// API 环境配置
class EnvEntity {
  EnvEntity({
    required this.label,
    required this.code,
    required this.baseUrls,
  });
  late final String label;
  late final String code;
  late final EnvBaseUrlEntity baseUrls;

  EnvEntity.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    code = json['code'];
    baseUrls = EnvBaseUrlEntity.fromJson(json['baseUrls']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['code'] = code;
    data['baseUrls'] = baseUrls.toJson();
    return data;
  }
}

/// API baseUrl 配置
class EnvBaseUrlEntity {
  EnvBaseUrlEntity({
    this.base,
    this.open,
  });
  late final String? base;
  late final String? open;

  EnvBaseUrlEntity.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    open = json['open'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['base'] = base;
    data['open'] = open;
    return data;
  }
}

/// API baseUrl 标识值
enum BaseUrlCodes {
  base(value: 'base', label: "基础服务"),
  open(value: 'open', label: "开放服务");

  final String value;
  final String label;

  const BaseUrlCodes({
    required this.value,
    required this.label,
  });
}
