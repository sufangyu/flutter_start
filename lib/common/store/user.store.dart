import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class UserStore extends GetxController {
  static UserStore to() => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;

  // Token
  String token = '';
  bool get hasToken => token.isNotEmpty;

  // 用户 profile
  final _profile = UserLoginResponseEntity().obs;
  UserLoginResponseEntity get profile => _profile.value;

  @override
  void onInit() async {
    super.onInit();

    getInitDataFromStorage();
  }

  /// 初始化本地缓存的数据
  Future<void> getInitDataFromStorage() async {
    if (GetPlatform.isIOS & kDebugMode) {
      Directory libDir = await getLibraryDirectory();
      LoggerUtil.info("iOS libDir::${libDir.path}");
    }

    String accessToken = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    String profileStorage =
        StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    UserLoginResponseEntity profile = profileStorage.isEmpty
        ? UserLoginResponseEntity()
        : UserLoginResponseEntity.fromJson(jsonDecode(profileStorage));

    _profile(profile);
    token = accessToken;
    _isLogin.value = token.isNotEmpty;
  }

  // 保存 profile
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _profile(profile);
    token = profile.accessToken ?? '';
    _isLogin.value = true;

    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    StorageService.to
        .setString(STORAGE_USER_TOKEN_KEY, profile.accessToken ?? '');
  }

  /// 注销
  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);

    _profile.value = UserLoginResponseEntity();
    token = '';
    _isLogin.value = false;
  }
}
