import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late final SharedPreferences _prefs;

  /// 初始化
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// 设置 string 缓存
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// 设置 bool 缓存
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// 设置 list 缓存
  Future<bool> setList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// 获取 string 缓存
  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  /// 获取 bool 缓存
  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  /// 获取 list 缓存
  List<String> getList(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  /// 删除指定缓存
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
}
