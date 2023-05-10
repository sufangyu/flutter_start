import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/common/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/pages/frame/sign_in/index.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  // 密码登录表单
  Widget _buildPasswordForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: 320.w,
      // margin: EdgeInsets.only(top: 49.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("密码登录", style: TextStyle(fontSize: 22.sp)),
          SizedBox(height: 16.h),
          // email input
          inputTextEdit(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
            marginTop: 0,
            // autofocus: true,
          ),
          // password input
          inputTextEdit(
            controller: controller.passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: controller.handleForgotPassword,
              child: Text(
                "忘记密码？",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryElementText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: controller.state.isAgreed,
                // activeColor: Colors.red, //选中时的颜色
                onChanged: (value) {
                  controller.state.isAgreed = value!;
                },
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: "已阅读且同意", style: TextStyle(fontSize: 12.sp)),
                  TextSpan(
                      text: "《用户协议》",
                      style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
                  TextSpan(text: "与", style: TextStyle(fontSize: 12.sp)),
                  TextSpan(
                    text: "《隐私协议》",
                    style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  ),
                ]),
              ),
            ],
          ),
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: btnFlatButtonWidget(
              width: 320.w,
              onPressed: controller.handleSignIn,
              gbColor: AppColors.primaryElement,
              title: "登录",
            ),
          ),
        ],
      ),
    );
  }

  // 手机号登录表单
  Widget _buildMobileForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: 320.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("验证码登录", style: TextStyle(fontSize: 22.sp)),
          const Text("未注册手机号验证后自动注册并登录",
              style: TextStyle(color: Colors.black38)),
          SizedBox(height: 16.h),
          inputTextEdit(
            controller: controller.mobileController,
            keyboardType: TextInputType.phone,
            hintText: "输入手机号",
            marginTop: 0,
            autofocus: true,
          ),
          Row(
            children: [
              Checkbox(
                value: controller.state.isAgreed,
                // activeColor: Colors.red, //选中时的颜色
                onChanged: (value) {
                  controller.state.isAgreed = value!;
                },
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: "已阅读且同意", style: TextStyle(fontSize: 12.sp)),
                  TextSpan(
                      text: "《用户协议》",
                      style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
                  TextSpan(text: "与", style: TextStyle(fontSize: 12.sp)),
                  TextSpan(
                    text: "《隐私协议》",
                    style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  ),
                ]),
              ),
            ],
          ),
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: btnFlatButtonWidget(
              width: 320.w,
              onPressed: controller.handleSignInByMobile,
              gbColor: AppColors.primaryElement,
              title: "登录",
            ),
          ),
        ],
      ),
    );
  }

  // 第三方登录
  Widget _buildThirdPartyLogin() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(bottom: 40.h),
      child: Column(
        children: <Widget>[
          // title
          Text(
            "其他登录方式",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.primaryText, fontSize: 14.sp),
          ),
          // 按钮
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              children: <Widget>[
                btnFlatButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 80.w,
                  iconFileName: "wechat",
                ),
                const Spacer(),
                btnFlatButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 80.w,
                  iconFileName: "qq",
                ),
                const Spacer(),
                btnFlatButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 80.w,
                  iconFileName: "weibo",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 注册按钮
  Widget _buildSignUpButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: btnFlatButtonWidget(
        onPressed: controller.handleNavSignUp,
        width: 290,
        gbColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "用户注册",
        fontSize: 16.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 可以通过设置 这个属性 防止键盘 覆盖内容 或者 键盘 撑起内容
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        // leading: const Icon(Icons.arrow_back_ios),
        actions: [
          InkWell(
            onTap: controller.changeLoginType,
            child: Align(
              child: Obx(
                () => Text(
                  controller.state.loginType == LoginType.mobile
                      ? "密码登录"
                      : "手机号登录",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Obx(
              () => controller.state.loginType == LoginType.password
                  ? _buildPasswordForm()
                  : _buildMobileForm(),
            ),
            const Spacer(),
            _buildThirdPartyLogin(),
            _buildSignUpButton(),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }
}
