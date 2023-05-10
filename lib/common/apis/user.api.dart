import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/http/index.dart';

class UserAPI {
  /// 用户登录
  static Future<UserLoginResponseEntity> login(
    UserLoginRequestEntity? params,
  ) async {
    var response = await HttpUtil().post(
      'https://mock.apifox.cn/m1/1124717-0-default/user/login',
      data: params?.toJson(),
    );

    return UserLoginResponseEntity.fromJson(response?.data);
  }
}
