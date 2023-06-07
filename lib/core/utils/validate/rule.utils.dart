import 'regex.util.dart';

class RuleUtils {
  static isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static isMobile(String value) {
    return value.startsWith('1') && value.length == 11;
  }

  static isEmail(String value) {
    return isEmpty(value) ?? RegExp(RegexUtil.email).hasMatch(value);
  }
}
