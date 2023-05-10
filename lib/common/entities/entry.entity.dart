import 'package:flutter/material.dart';

class Entry {
  /// 入口描述
  late final String label;

  /// icon 图标
  late final IconData? icon;

  /// 入口路径
  late final String? path;

  Entry({
    required this.label,
    this.icon,
    this.path,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    icon = json['icon'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['icon'] = icon;
    data['path'] = path;
    return data;
  }
}
