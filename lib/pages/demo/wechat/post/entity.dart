import 'package:flutter/material.dart';

/// 菜单项 entity
class MenuItemEntity {
  /// 图标
  final IconData? icon;

  /// 标题
  final String title;

  /// 右侧内容
  final String? right;

  Function()? onTap;

  MenuItemEntity({
    this.icon,
    required this.title,
    this.right,
    this.onTap,
  });
}
