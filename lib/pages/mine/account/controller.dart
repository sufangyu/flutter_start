import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  AccountController();

  List list = [
    {"label": "网络请求", "icon": Icons.network_wifi_sharp},
    {"label": "引导页", "icon": Icons.airport_shuttle},
    {"label": "图片选择", "icon": Icons.all_inclusive},
    {"label": "地图、定位", "icon": Icons.beach_access},
    {"label": "相机应用", "icon": Icons.add_a_photo_outlined},
    {"label": "权限申请", "icon": Icons.access_alarm},
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
