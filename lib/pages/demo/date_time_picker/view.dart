import 'package:day/day.dart';
import 'package:day/plugins/relative_time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DemoDateTimePickerPage extends GetView<DemoDateTimePickerController> {
  const DemoDateTimePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime(2022, 6, 18, 23, 59, 59);
    String dateTimeStr = '2022-08-01 23:59:59';

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

          ///
          const Divider(height: 36),
          const Text(
            '日期格式化: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ListTile(
            title: Text("现在：${Day().format('YYYY-MM-DD HH:mm:ss')}"),
          ),
          ListTile(
            title: Text(
                "指定【$dateTime】：${Day.fromDateTime(dateTime).format('YYYY-MM-DD HH:mm')}"),
          ),
          ListTile(
            title: Text(
                "指定【$dateTimeStr】：${Day.fromString(dateTimeStr).format('YYYY年MM月DD日 HH时mm分')}"),
          ),
          ListTile(
            title: Text("现在时间：${Day().format('HH:mm:ss')}"),
          ),
          ListTile(
            title: Text("现在时间：${Day().format('HH时mm分ss秒')}"),
          ),
          ListTile(
            title: Text("时间差：${Day.fromDateTime(dateTime).fromNow()}"),
          ),
        ],
      ),
    );
  }
}
