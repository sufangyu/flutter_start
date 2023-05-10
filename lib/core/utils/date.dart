import 'package:intl/intl.dart';

/// 格式化时间
String timeLineFormat(DateTime? dt) {
  // DateTime
  var now = DateTime.now();
  DateTime curDt = dt ?? now;
  var difference = now.difference(curDt);

  // 1天内
  if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  }
  // 30天内
  else if (difference.inDays < 30) {
    return "${difference.inDays} days ago";
  }
  // MM-dd
  else if (difference.inDays < 365) {
    final dtFormat = DateFormat('MM-dd');
    return dtFormat.format(curDt);
  }
  // yyyy-MM-dd
  else {
    final dtFormat = DateFormat('yyyy-MM-dd');
    var str = dtFormat.format(curDt);
    return str;
  }
}
