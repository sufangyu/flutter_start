import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  /// 是否已打开（默认false）
  bool isAlreadyOpen = false;

  /// 是否同意协议
  bool isAgreementProtocol = false;

  /// 发布渠道
  final String _channel = "";
  String get channel => _channel;

  /// 包信息
  PackageInfo? _platform;
  String get version => _platform?.version ?? '';

  /// 是否 release 版本
  bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 当前语言（默认 zh-Hans）
  Locale locale = const Locale('zh', 'Hans');

  /// 可选语言集合
  List<Locale> languages = [
    const Locale('zh', 'Hans'),
    const Locale('zh', 'HK'),
    const Locale('en', 'US'),
  ];

  /// API 环境标识
  final String _apiEnvCodeDefault = 'prod';
  String apiEnvCode = 'prod';

  @override
  void onInit() async {
    super.onInit();

    await getPlatform();
    onInitLocale();
    getApiEnvCode();

    isAlreadyOpen = StorageService.to.getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    isAgreementProtocol =
        StorageService.to.getBool(STORAGE_AGREEMENT_PROTOCOL_KEY);
  }

  /// 标记用户已打开APP
  Future<bool> saveAlreadyOpen() async {
    isAlreadyOpen = true;
    return StorageService.to.setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
  }

  /// 标记用户已同意协议
  Future<bool> saveAgreementProtocol() async {
    isAgreementProtocol = true;
    return StorageService.to.setBool(STORAGE_AGREEMENT_PROTOCOL_KEY, true);
  }

  /// 获取包信息
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  /// 获取 API 环境标识
  void getApiEnvCode() {
    /// TODO: flutter run main.dart [参数]
    /// 1. 打release包：不可切环境、忽略本地缓存的API环境标识
    /// 2. 打指定环境的包、是否可以切换环境
    String apiEnvCodeFromStorage =
        StorageService.to.getString(STORAGE_API_ENV_CODE_KEY);
    LoggerUtil.info("apiEnvCodeFromStorage::-$apiEnvCodeFromStorage-");

    if (apiEnvCodeFromStorage != '') {
      apiEnvCode = apiEnvCodeFromStorage;
    }
  }

  /// 设置 API 环境标识
  Future<bool> setApiEnvCode(String code) {
    if (code == '') {
      return Future(() => false);
    }
    apiEnvCode = code;
    return StorageService.to.setString(STORAGE_API_ENV_CODE_KEY, code);
  }

  /// 重置 API 环境标识
  Future<bool> resetApiEnvCode() {
    apiEnvCode = _apiEnvCodeDefault;
    return StorageService.to.remove(STORAGE_API_ENV_CODE_KEY);
  }

  /// 初始化语言
  void onInitLocale() {
    var langCode = StorageService.to.getString(STORAGE_LANGUAGE_CODE);

    if (langCode.isEmpty) {
      return;
    }
    int index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) {
      return;
    }
    locale = languages[index];
  }

  /// 更新当前语言
  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to.setString(STORAGE_LANGUAGE_CODE, value.languageCode);
  }
}
