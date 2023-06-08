import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:get/get.dart';

import 'state.dart';

class ApplicationController extends GetxController {
  ApplicationController();

  final state = ApplicationState();

  /// tab 页标题集合
  late final List<String> tabTitles;

  /// 页控制器
  late final PageController pageController;

  /// 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;

  /// tab 栏动画
  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);

    // pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 200),
    //   curve: Curves.ease,
    // );
  }

  /// tab 栏切换
  void handlePageChanged(int page) {
    state.page = page;
  }

  @override
  void onInit() {
    super.onInit();

    // 准备一些静态数据
    tabTitles = ['Welcome', 'Category', 'Bookmarks', 'Mine'];

    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.home,
          color: AppColors.secondaryElementText,
        ),
        label: '主页',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.grid,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.grid,
          color: AppColors.secondaryElementText,
        ),
        label: '分类',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.tag,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.tag,
          color: AppColors.secondaryElementText,
        ),
        label: '标签',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.me,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.me,
          color: AppColors.secondaryElementText,
        ),
        label: '我的',
        backgroundColor: AppColors.primaryBackground,
      ),
    ];

    pageController = PageController(initialPage: state.page);
  }
}
