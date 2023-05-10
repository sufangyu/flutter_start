import 'package:flutter/material.dart';
import 'package:flutter_start/common/apis/user.api.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/store/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class SignInController extends GetxController {
  SignInController();

  SignInState state = SignInState();

  /// 切换登录类型
  void changeLoginType() {
    state.isAgreed = false;
    switch (state.loginType) {
      case LoginType.mobile:
        state.loginType = LoginType.password;
        break;
      case LoginType.password:
        state.loginType = LoginType.mobile;
        break;
    }
  }

  /// 手机号
  final TextEditingController mobileController =
      TextEditingController(text: '132111111');

  /// email的控制器
  final TextEditingController emailController =
      TextEditingController(text: 'test@qq.com');

  /// 密码的控制器
  final TextEditingController passController =
      TextEditingController(text: '123456');

  /// 跳转 注册界面
  handleNavSignUp() {
    Get.toNamed(AppRoutes.SIGN_UP);
  }

  /// 忘记密码
  handleForgotPassword() {
    toastInfo(msg: '忘记密码');
  }

  /// 执行登录操作 (账密)
  handleSignIn() async {
    if (state.isAgreed == false) {
      toastInfo(msg: '请先同意协议');
      return;
    }
    if (!duIsEmail(emailController.value.text)) {
      toastInfo(msg: '请正确输入邮件');
      return;
    }
    if (!duCheckStringLength(passController.value.text, 6)) {
      toastInfo(msg: '密码不能小于6位');
      return;
    }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      email: emailController.value.text,
      password: duSHA256(passController.value.text),
    );
    UserLoginResponseEntity userProfile = await UserAPI.login(
      params,
    );

    UserStore.to().saveProfile(userProfile);
    Get.offAllNamed(AppRoutes.APPLICATION);
    Get.back();
  }

  /// 手机验证码登录
  handleSignInByMobile() async {
    if (state.isAgreed == false) {
      toastInfo(msg: '请先同意协议');
      return;
    }

    if (!mobileController.value.text.startsWith('1') &&
        mobileController.value.text.length != 11) {
      toastInfo(msg: '手机号格式不对');
      return;
    }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      email: emailController.value.text,
      password: duSHA256(passController.value.text),
    );
    UserLoginResponseEntity userProfile = await UserAPI.login(
      params,
    );

    UserStore.to().saveProfile(userProfile);
    Get.offAllNamed(AppRoutes.APPLICATION);
    Get.back();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
