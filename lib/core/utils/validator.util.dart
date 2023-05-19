class ValidatorUtil {
  /// 检查邮箱格式
  static bool isEmail(String? input) {
    if (input == null || input.isEmpty) return false;
    // 邮箱正则
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    return RegExp(regexEmail).hasMatch(input);
  }

  /// 检查字符长度
  static bool checkStringLength(String? input, int length) {
    if (input == null || input.isEmpty) return false;
    return input.length >= length;
  }
}
