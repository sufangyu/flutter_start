import 'package:flutter/material.dart';
import 'package:flutter_start/common/values/index.dart';
import 'package:flutter_start/pages/bookmarks/index.dart';
import 'package:flutter_start/pages/category/index.dart';
import 'package:flutter_start/pages/main/index.dart';
import 'package:flutter_start/pages/mine/account/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  /// 底部导航
  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.state.page,
        fixedColor: AppColors.primaryElement,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handleNavBarTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // selectedLabelStyle: const TextStyle(height: 1.2),
        // unselectedLabelStyle: const TextStyle(height: 1.2),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      // 不可左右滑动
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
      children: const <Widget>[
        MainPage(),
        CategoryPage(),
        BookmarksPage(),
        AccountPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
