import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/pages/frame/az_list_view/entity/city.entity.dart';
import 'package:get/get.dart';

import 'controller_city_custom.dart';

double susItemHeight = 36;

class AZListViewCityCustomPage extends GetView<AZListViewCityCustomController> {
  const AZListViewCityCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自定义头部')),
      body: Column(
        children: [
          const ListTile(
              title: Text("当前城市"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.place, size: 20.0),
                  Text(" 成都市"),
                ],
              )),
          const Divider(height: 0),
          Expanded(
            child: Obx(() {
              var cityList = controller.state.cityList;
              return AzListView(
                data: cityList,
                itemCount: cityList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildHotCity();
                  }

                  CityEntity currentCity = cityList[index];
                  return ListTile(
                    title: Text(currentCity.name),
                    onTap: () => Get.back(result: currentCity),
                  );
                },
                susItemHeight: susItemHeight,
                susItemBuilder: (BuildContext context, int index) {
                  CityEntity currentCity = cityList[index];
                  String tag = currentCity.getSuspensionTag();
                  if (controller.imgFavorite == tag) {
                    return Container();
                  }

                  return _buildSusItem(context, tag, susHeight: susItemHeight);
                },
                indexBarData: SuspensionUtil.getTagIndexList(cityList),
                indexBarOptions: IndexBarOptions(
                  needRebuild: true,
                  color: Colors.transparent,
                  downColor: const Color(0xFFeeeeee),
                  localImages: [controller.imgFavorite], // local images
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildHotCity() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.0,
        children: controller.hotCityList.map((e) {
          return OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(e.name),
            ),
            onPressed: () {},
          );
        }).toList(),
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
