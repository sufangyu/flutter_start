import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DemoDateTimePickerPage extends GetView<DemoDateTimePickerController> {
  const DemoDateTimePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Time Picker'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: controller.normalDatePicker,
            child: const Text("日期选择器(自定义主题+时间范围)"),
          ),
          ElevatedButton(
            onPressed: controller.currentDatePicker,
            child: const Text("日期选择器(默认日期)"),
          ),
          const Divider(height: 36),
          ElevatedButton(
            onPressed: controller.normalTimePicker,
            child: const Text("时间选择器(默认日期)"),
          ),
          ElevatedButton(
            onPressed: controller.customDatePicker,
            child: const Text("时间（自定义选择项）"),
          ),
          const Divider(height: 36),
          ElevatedButton(
            onPressed: controller.dateTimePicker,
            child: const Text("日期+时间"),
          ),
          const Divider(height: 36),
          const Text('日期格式化: ', style: TextStyle(fontWeight: FontWeight.bold)),
          ListTile(
            title: Text("${DateTime.now()} ->> ${formatDate(
              DateTime.now(),
              [yyyy, '-', mm, '-', dd],
            )}"),
          ),
          ListTile(
            title: Text("${DateTime.now()} ->> ${formatDate(
              DateTime.now(),
              [yyyy, '年', mm, '月', dd, '日'],
            )}"),
          ),
          ListTile(
            title: Text("${DateTime.now()} ->> ${formatDate(
              DateTime.now(),
              [HH, ':', nn, ':', ss],
            )}"),
          ),
          ListTile(
            title: Text("${DateTime.now()} ->> ${formatDate(
              DateTime.now(),
              [HH, '时', nn, '分', ss, '秒'],
            )}"),
          ),
        ],
      ),
    );
  }
}
