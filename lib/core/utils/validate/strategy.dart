import 'rule.utils.dart';

class Strategy {
  /// 必填
  String required(value, String message) {
    return (value == '' || value == 0 || value == null || value.isEmpty)
        ? message
        : '';
  }

  /// 正则匹配
  String pattern(String value, String regStr, String message) {
    return !RegExp(regStr).hasMatch(value) ? message : '';
  }

  // 最小长度
  String minLength(value, int len, String message) {
    if (value is String) {
      return value.length < len ? message : '';
    }

    if (value is int || value is double) {
      var number = value.toDouble();
      return number < len ? message : '';
    }

    return message;
  }

  /// 最小长度
  String maxLength(value, int len, String message) {
    if (value is String) {
      return value.length > len ? message : '';
    }

    if (value is int || value is double) {
      var number = value.toDouble();
      return number > len ? message : '';
    }

    return message;
  }

  /// 手机号码（1开头、11位）
  String mobile(String value, String message) {
    return !RuleUtils.isMobile(value) ? message : '';
  }

  /// 电子邮箱
  String email(String value, String message) {
    return !RuleUtils.isEmail(value) ? message : '';
  }
}
