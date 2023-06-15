import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_start/pages/frame/az_list_view/entity/city.entity.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AZListViewPage extends GetView<AZListViewController> {
  const AZListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Material(
                color: Colors.black12,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(left: 8, top: 8, right: 8),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 15.0),
                        height: 50.0,
                        child: const Text("当前城市: 成都市"),
                      ),
                      Expanded(
                        child: Obx(() {
                          var cityList = controller.state.cityList;
                          return Stack(
                            children: [
                              AzListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemScrollController:
                                    controller.itemScrollController,
                                data: cityList,
                                itemCount: cityList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  CityEntity currentCity = cityList[index];
                                  return ListTile(
                                    title: Text(currentCity.name),
                                    onTap: () => Get.back(result: currentCity),
                                  );
                                },
                                susItemBuilder:
                                    (BuildContext context, int index) {
                                  CityEntity currentCity = cityList[index];
                                  String tag = currentCity.getSuspensionTag();
                                  return _buildSusItem(context, tag);
                                },
                                padding: EdgeInsets.zero,
                                indexBarData: const ['★', ...kIndexBarData],
                              ),
                              _buildEmpty(cityList),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 空提示
  Widget _buildEmpty(List<CityEntity> cityList) {
    return cityList.isEmpty
        ? Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                '没有搜索结果',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  /// 头部搜索
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      height: 50.0,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextField(
                controller: controller.textEditingController,
                onChanged: (value) => controller.search(value),
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Offstage(
                    offstage: controller.textEditingController.text.isEmpty,
                    child: InkWell(
                      onTap: () {
                        controller.textEditingController.clear();
                        controller.search('');
                      },
                      child: const Icon(Icons.cancel, color: Colors.grey),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: '城市中文名或拼音',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "取消",
                style: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 每项的索引标识
  Widget _buildSusItem(
    BuildContext context,
    String tag, {
    double susHeight = 40,
  }) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: const Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: const TextStyle(fontSize: 14.0, color: Color(0xFF666666)),
      ),
    );
  }
}
