import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class CityEntity extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;

  CityEntity({
    required this.name,
    this.tagIndex,
    this.namePinyin,
  });

  CityEntity.fromJson(Map<String, dynamic> json) : name = json['name'];

  // CityEntity.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   tagIndex = json['tagIndex'];
  //   namePinyin = json['namePinyin'];
  // }

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
