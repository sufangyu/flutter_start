// import 'package:flutter_start/core/utils/index.dart';

import 'strategy.dart';

class Validate extends Strategy {
  /// 校验规则配置
  Map<String, List<Map<String, Object>>> rules;

  /// 校验参数
  Map<String, Object> params;

  Validate(this.rules, this.params) {
    add(rules);
  }

  /// 校验函数列表
  List<Function> validateList = [];

  /// 开始校验
  String? start() {
    // LoggerUtil.debug("validateList::$validateList");
    for (int idx = 0; idx < validateList.length; idx++) {
      String message = validateList[idx]();
      if (message != '') {
        return message;
      }
    }

    return null;
  }

  /// 添加校验 List
  void add(Map<String, List<Map<String, Object>>> rules) {
    var strategies = {
      'required': required,
      'pattern': pattern,
      'minLength': minLength,
      'maxLength': maxLength,
      'mobile': mobile,
      'email': email,
    };

    rules.forEach((keyIndex, ruleList) {
      // LoggerUtil.debug("$keyIndex ->> $ruleList");
      var curValue = params[keyIndex];

      for (var item in ruleList) {
        // LoggerUtil.debug("ruleList:: $curValue ->> $item");
        // 循环处理每一项校验
        item.forEach((type, value) {
          if (!strategies.containsKey(type)) {
            return;
          }

          String errMsg = item['message'] as String;
          // 校验类型值
          // var conditionVal = item[type];
          if ((type == 'required' ||
                  type == 'mobile' ||
                  type == 'noEmptyList') &&
              value == true) {
            // LoggerUtil.debug(
            //     "添加校验函数::校验值->>$curValue, 类型->>$type, 类型值->>$value, 错误->>$errMsg");

            validateList.add(() {
              return strategies[type]!(curValue, errMsg);
            });
          } else {
            // LoggerUtil.debug(
            //     "添加校验函数::校验值->>$curValue, 类型->>$type, 类型值->>$value, 错误->>$errMsg");
            validateList.add(() {
              return strategies[type]!(curValue, value, errMsg);
            });
          }
        });
      }
    });
  }
}
