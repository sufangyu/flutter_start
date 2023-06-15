import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/core/utils/index.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import 'state.dart';

class DemoDateTimePickerController extends GetxController {
  DemoDateTimePickerState state = DemoDateTimePickerState();

  /// 生命周期 -------------------------------------------

  /// 静态数据、普通函数 -----------------------------------

  void normalDatePicker() {
    picker.DatePicker.showDatePicker(
      Get.context!,
      // onChanged: (date) {
      //   LoggerUtil.debug("change $date in time zone");
      // },
      onConfirm: (date) {
        LoggerUtil.debug("选择::${date.timeZoneOffset}");
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.zh,
      showTitleActions: true,
      minTime: DateTime(2018, 3, 5),
      // maxTime: DateTime(2019, 6, 7),
      // 自定义主题
      theme: const picker.DatePickerTheme(
        headerColor: Colors.orange,
        backgroundColor: Colors.blue,
        itemStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  void currentDatePicker() {
    picker.DatePicker.showDatePicker(
      Get.context!,
      locale: picker.LocaleType.zh,
      onConfirm: (date) {
        LoggerUtil.debug(''
            'confirm::$date, '
            'formatDate::${Day.fromDateTime(date).format('YYYY年MM月DD日')}'
            '');
      },
      currentTime: DateTime(2008, 12, 31, 23, 12, 34),
    );
  }

  void normalTimePicker() {
    picker.DatePicker.showTimePicker(
      Get.context!,
      locale: picker.LocaleType.zh,
      showSecondsColumn: false, // 是否显示秒
      onConfirm: (date) {
        LoggerUtil.debug('confirm::$date');
      },
      // currentTime: DateTime(2008, 12, 31, 23, 12, 34),
    );
  }

  void customDatePicker() {
    picker.DatePicker.showPicker(
      Get.context!,
      locale: picker.LocaleType.zh,
      onConfirm: (date) {
        LoggerUtil.debug('confirm $date');
      },
      pickerModel: CustomPicker(
        currentTime: DateTime.now(),
        locale: picker.LocaleType.zh,
      ),
    );
  }

  void dateTimePicker() {
    picker.DatePicker.showDateTimePicker(
      Get.context!,
      locale: picker.LocaleType.zh,
    );
  }
}

/// 自定义选择面板
class CustomPicker extends picker.CommonPickerModel {
  // 补0
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({
    DateTime? currentTime,
    picker.LocaleType? locale,
  }) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            currentLeftIndex(),
            currentMiddleIndex(),
            currentRightIndex(),
          )
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            currentLeftIndex(),
            currentMiddleIndex(),
            currentRightIndex(),
          );
  }
}
