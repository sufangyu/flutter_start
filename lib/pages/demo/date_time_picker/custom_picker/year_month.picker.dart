import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class YearMonthPicker extends DatePickerModel {
  YearMonthPicker({
    DateTime? currentTime,
    DateTime? maxTime,
    DateTime? minTime,
    LocaleType? locale,
  }) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.maxTime = maxTime ?? DateTime(2089, 12, 31);
    this.minTime = minTime ?? DateTime(1970, 1, 1);
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 0];
  }

  /// 返回每个月的1号0时0分0秒, 需使用时再去做格式化
  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month)
        : DateTime(currentTime.year, currentTime.month);
  }
}
