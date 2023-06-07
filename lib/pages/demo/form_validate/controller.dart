import 'package:flutter/cupertino.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class FormValidateController extends GetxController {
  FormValidateState state = FormValidateState();
  List<String> radioList = ['刘德华', '张学友', '郭富城', '黎明'];
  List<String> checkboxList = ['Flutter', 'RN', 'React', 'Vue'];

  /// TextField controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  /// 单选框组
  void onChangeRadioList(String? value) {
    LoggerUtil.debug("onChangeRadioList::$value");
    state.radioListSelected = value ?? '';
  }

  /// 复选框组
  void onChangeCheckboxList(bool? value, String item) {
    LoggerUtil.debug("onChangeCheckboxList::$value");
    if (value!) {
      state.checkboxListSelected.add(item);
    } else {
      state.checkboxListSelected.remove(item);
    }
  }

  /// 提交表单
  void submit() {
    Map<String, Object> params = {
      'username': usernameController.text,
      'password': passwordController.text,
      'number': numberController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'captcha': '1',
      'star': state.radioListSelected,
      'hobby': state.checkboxListSelected,
    };
    LoggerUtil.debug("params::$params");
    var rules = {
      'username': [
        {'required': true, 'message': '用户名不能为空'},
        {'minLength': 4, 'message': '用户名长度要至少4位数'},
      ],
      'password': [
        {'required': true, 'message': '密码不能为空'},
        {'minLength': 6, 'message': '密码长度最低6位数'},
      ],
      'mobile': [
        {'required': true, 'message': '请输入手机号码'},
        {'mobile': true, 'message': '请输入正确的手机号码'},
      ],
      'email': [
        {'pattern': RegexUtil.email, 'message': '邮箱格式不正确'}
      ],
      'captcha': [
        {'required': true, 'message': '请输入短信验证码'}
      ],
      'hobby': [
        {'required': true, 'message': '请输入兴趣爱好'},
      ],
    };
    var validate = Validate(rules, params);
    var message = validate.start();
    LoggerUtil.debug("校验结果信息::$message");

    if (message != null) {
      LoadingUtil.toast(message);
    }
  }
}
