import 'dart:io';

import 'package:flutter/foundation.dart';

class Utils {
  /// 创建目录
  static createDir(String path) async {
    Directory dir = Directory(path);
    bool exist = dir.existsSync();

    if (exist) {
      // print('当前文件夹已经存在');
    } else {
      var result = await dir.create();
      return result;
    }
  }

  /// 转换类名
  static String transformClassName(String className) {
    List<String> classNameLetters = [];
    List<String> pageNameStrList = className.split('_');
    // 遍历处理首字母是否大写
    for (var str in pageNameStrList) {
      List<String> letterList = str.split('');
      bool isUp = letterList.first.contains(RegExp(r'[A-Z]'));
      if (!isUp) {
        letterList.first = letterList.first.toUpperCase();
      }

      classNameLetters.add(letterList.join(''));
    }

    return classNameLetters.join('');
  }

  static void log(String msg) {
    if (kDebugMode) {
      print(msg);
    }
  }
}
