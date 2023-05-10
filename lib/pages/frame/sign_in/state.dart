import 'package:get/get.dart';

/// 登录方式
enum LoginType {
  mobile,
  password,
}

class SignInState {
  /// 登录方式
  final Rx<LoginType> _loginType = LoginType.password.obs;
  set loginType(LoginType value) => _loginType.value = value;
  LoginType get loginType => _loginType.value;

  /// 是否同意协议
  final Rx<bool> _isAgreed = false.obs;
  set isAgreed(bool value) => _isAgreed.value = value;
  bool get isAgreed => _isAgreed.value;
}
