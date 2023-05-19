import 'package:flutter_start/common/entities/index.dart';
import 'package:flutter_start/core/http/index.dart';
import 'package:flutter_start/core/utils/index.dart';

class WechatAPI {
  static String baseurl = 'https://mock.apifox.cn/m1/2249037-0-default';

  /// 朋友圈
  static Future<List<TimelineEntity>> timelineNew() async {
    var response = await HttpUtil().get(
      '$baseurl/timeline/news',
      // hasLoading: false,
    );

    // 处理 data 是数组的情况
    return List.from(response?.data ?? [])
        .map((it) => TimelineEntity.fromJson(it))
        .toList();
  }

  /// 点赞
  static Future like(String id) async {
    var res = await HttpUtil().post(
      '$baseurl/timeline/$id/like',
      hasLoading: false,
    );
    return res;
  }

  /// 评论
  static Future comment(String id, String content) async {
    LoggerUtil.debug("comment::$id, $content");

    var res = await HttpUtil().post(
      '$baseurl/timeline/$id/comment',
      data: {
        'content': content,
      },
      hasLoading: false,
    );
    return res;
  }
}
