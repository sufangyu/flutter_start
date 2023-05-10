import 'package:flutter/material.dart';
import 'package:flutter_start/common/routers/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  SignUpController();

  /// 全名
  final TextEditingController fullNameController =
      TextEditingController(text: 'test');

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

  /// 执行登录操作
  handleSignUp() async {
    // if (!duIsEmail(emailController.value.text)) {
    //   toastInfo(msg: '请正确输入邮件');
    //   return;
    // }
    // if (!duCheckStringLength(passController.value.text, 6)) {
    //   toastInfo(msg: '密码不能小于6位');
    //   return;
    // }
    if (!duCheckStringLength(fullNameController.value.text, 5)) {
      toastInfo(msg: '用户名不能小于5位');
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
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
