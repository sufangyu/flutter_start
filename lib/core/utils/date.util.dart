import 'package:intl/intl.dart';

class DateUtil {
  /// 格式化时间
  static String timeLineFormat(DateTime? dt) {
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

  /// 格式化距离现在的相对时间
  static fromNow(String? dateStr) {
    if (dateStr == null) {
      return "";
    }
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    Duration diff = now.difference(date);
    if (diff.inDays > 0) {
      return "${diff.inDays} 天前";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} 小时前";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} 分钟前";
    } else {
      return "刚刚";
    }
  }
}
