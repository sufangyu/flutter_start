import 'package:get/get.dart';

class ApplicationState {
  /// 当前 tabBar page 序号
  final _page = 0.obs;
  set page(value) => _page.value = value;
  get page => _page.value;
}
