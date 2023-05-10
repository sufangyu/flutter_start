import 'package:get/get.dart';

class GuideState {
  /// 当前激活序号
  final _curIndex = 0.obs;
  set curIndex(int value) => _curIndex.value = value;
  int get curIndex => _curIndex.value;
}
