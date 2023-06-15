import 'package:get/get.dart';

import 'entity/index.dart';

class AZListViewState {
  final _cityList = <CityEntity>[].obs;
  set cityList(value) => _cityList.value = value;
  List<CityEntity> get cityList => _cityList;
}
