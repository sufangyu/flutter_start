import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  // appBar
  AppBar _buildAppBar() {
    return transparentAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
        onPressed: () => Get.back(),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.info_outline),
          color: AppColors.primaryText,
          onPressed: () => toastInfo(msg: '这是注册界面'),
        ),
      ],
    );
  }

  // Form title
  Widget _buildFormTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: Text(
        'Sign up',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
          height: 1,
        ),
      ),
    );
  }

  // 登录表单
  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(top: 49.h),
      child: Column(
        children: <Widget>[
          inputTextEdit(
            controller: controller.fullNameController,
            keyboardType: TextInputType.text,
            hintText: 'Full name',
            marginTop: 0,
          ),
          // email
          inputTextEdit(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
          ),
          // password
          inputTextEdit(
            controller: controller.passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),

          // 创建
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: btnFlatButtonWidget(
              onPressed: controller.handleSignUp,
              width: 295.w,
              fontWeight: FontWeight.w600,
              title: "Create an account",
            ),
          ),

          // Forgot password
          Container(
            margin: EdgeInsets.only(top: 20.h),
            child: TextButton(
              onPressed: () => toastInfo(msg: '跳转到找回密码页面'),
              child: Text(
                "Forgot password?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryElementText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 有账号
  Widget _buildHaveAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: btnFlatButtonWidget(
        onPressed: () => Get.back(),
        width: 294.w,
        gbColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "I have an account",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 可以通过设置 这个属性 防止键盘 覆盖内容 或者 键盘 撑起内容
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildFormTitle(),
            _buildInputForm(),
            const Spacer(),
            _buildHaveAccountButton(),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
