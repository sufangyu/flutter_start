import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'zh_HK.dart';
import 'zh_Hans.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  ///
  static const fallbackLocale = Locale('zh', 'Hans');

  /// 语言配置
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_Hans': zh_Hans,
    'zh_HK': zh_HK,
  };
}