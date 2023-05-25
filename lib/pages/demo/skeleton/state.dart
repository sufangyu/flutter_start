import 'package:get/get.dart';

class SkeletonState {
  // final _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;

  /// 示例 1
  final RxBool _defaultFlag = false.obs;
  set defaultFlag(bool val) => _defaultFlag.value = val;
  bool get defaultFlag => _defaultFlag.value;
}
