import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import 'entity/index.dart';
import 'state.dart';

class AZListViewCityCustomController extends GetxController {
  List<CityEntity> hotCityList = [
    CityEntity(name: "北京市"),
    CityEntity(name: "广州市"),
    CityEntity(name: "成都市"),
    CityEntity(name: "深圳市"),
    CityEntity(name: "杭州市"),
    CityEntity(name: "武汉市"),
  ];

  String imgFavorite = 'assets/images/ic_favorite.png';

  AZListViewState state = AZListViewState();

  /// 生命周期 -------------------------------------------
  @override
  void onInit() {
    super.onInit();

    // 模拟加载数据
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  /// 静态数据、普通函数 -----------------------------------

  void _loadData() async {
    // 加载城市列表
    var result = await rootBundle.loadString('assets/data/china.json');

    state.cityList.clear();
    Map countyMap = json.decode(result);
    List list = countyMap['china'];
    for (var city in list) {
      state.cityList.add(CityEntity.fromJson(city));
    }

    _handleList(state.cityList);
  }

  /// 处理城市列表
  void _handleList(List<CityEntity> list) {
    if (list.isEmpty) return;

    // 处理按拼音首字母归类
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();

      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }

    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(state.cityList);

    // add header.
    state.cityList.insert(
      0,
      CityEntity(name: 'header', tagIndex: imgFavorite),
    ); //index bar support local images.
  }
}
