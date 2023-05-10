// https://www.webinovers.com/web-tools/json-to-dart-convertor

/// 用户注册请求
class UserRegisterRequestEntity {
  UserRegisterRequestEntity({
    required this.email,
    required this.password,
  });

  late final String email;
  late final String password;

  UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

/// 登录请求
class UserLoginRequestEntity {
  UserLoginRequestEntity({
    required this.email,
    required this.password,
  });

  late final String email;
  late final String password;

  UserLoginRequestEntity.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

/// 登录响应
class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  List<String>? channels;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.channels,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        channels: List<String>.from(json["channels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "channels":
            channels == null ? [] : List<dynamic>.from(channels!.map((x) => x)),
      };
}
