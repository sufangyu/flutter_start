import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

import 'entity/index.dart';
import 'state.dart';

class AZListViewController extends GetxController {
  final List<CityEntity> _hotCityList = [];
  final List<CityEntity> _originList = [];

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();
  final TextEditingController textEditingController = TextEditingController();

  AZListViewState state = AZListViewState();

  /// 生命周期 -------------------------------------------
  @override
  void onInit() {
    super.onInit();

    _getHotCityList();

    // 模拟加载数据
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  /// 静态数据、普通函数 -----------------------------------
  void _getHotCityList() {
    _hotCityList.add(CityEntity(name: '北京市', tagIndex: '★'));
    _hotCityList.add(CityEntity(name: '广州市', tagIndex: '★'));
    _hotCityList.add(CityEntity(name: '成都市', tagIndex: '★'));
    _hotCityList.add(CityEntity(name: '深圳市', tagIndex: '★'));
    _hotCityList.add(CityEntity(name: '杭州市', tagIndex: '★'));
    _hotCityList.add(CityEntity(name: '武汉市', tagIndex: '★'));

    state.cityList.addAll(_hotCityList);
    SuspensionUtil.setShowSuspensionStatus(state.cityList);
  }

  void _loadData() async {
    // 加载城市列表
    var result = await rootBundle.loadString('assets/data/china.json');

    state.cityList.clear();

    Map countyMap = json.decode(result);
    List list = countyMap['china'];
    for (var city in list) {
      city['namePinyin'] = PinyinHelper.getPinyinE(city['name']);
      _originList.add(CityEntity.fromJson(city));
    }

    _handleList(_originList);
  }

  /// 处理城市列表
  void _handleList(List<CityEntity> list, {bool hasHot = true}) {
    LoggerUtil.debug("hasHot::$hasHot, 处理城市列表::$list");
    state.cityList.clear();

    if (list.isEmpty) {
      return;
    }

    // 处理按拼音首字母归类
    for (int i = 0; i < list.length; i++) {
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

    state.cityList.addAll(list);

    // add hotCityList.
    if (hasHot == true) {
      state.cityList.insertAll(0, _hotCityList);
    }

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(state.cityList);

    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(index: 0);
    }
  }

  void search(String text) {
    if (text.isEmpty) {
      _handleList(_originList);
    } else {
      List<CityEntity> list = _originList.where((v) {
        return v.name.contains(text) ||
            v.namePinyin!.toLowerCase().startsWith(text.toLowerCase());
      }).toList();

      _handleList(list, hasHot: false);
    }
  }
}
