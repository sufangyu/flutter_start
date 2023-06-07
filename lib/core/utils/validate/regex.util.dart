// ignore_for_file: constant_identifier_names

/// 正则工具类
class RegexUtil {
  /// 电子邮箱
  static String email =
      "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";

  /// 纯数字
  static String digit = "[0-9]+";

  /// 含有数字
  static String containDigit = ".*[0-9].*";

  /// 纯字母
  static String letter = "[a-zA-Z]+";

  /// 包含小写字母
  static String smallContainLetter = ".*[a-z].*";

  /// 包含大写字母
  static String bigContainLetter = ".*[A-Z].*";

  /// 包含大小写字母
  static String containLetter = ".*[a-zA-Z].*";

  /// 纯中文
  static String chinese = "[\u4e00-\u9fa5]";

  /// 仅包含字母和数字
  static String letterDigit = "^[a-z0-9A-Z]+\$";

  /// 仅包含中文和大小写字母
  static String chineseLetter = "([\u4e00-\u9fa5]+|[a-zA-Z]+)";

  /// 仅包含大小写字母、中文、数字
  static String chineseLetterDigit = "^[a-z0-9A-Z\u4e00-\u9fa5]+\$";
}
