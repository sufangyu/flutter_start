import 'package:flutter/material.dart';

/// 默认宽高配置
var defaultWidth = 320.0;
var defaultHeight = 540.0;

/// 运动配置
var inDuration = const Duration(milliseconds: 150);
var outDuration = const Duration(milliseconds: 200);

/// 圆角配置
var _radius = 24.0;
var borderRadiusZero = const BorderRadius.all(Radius.zero);
var borderRadiusTop = BorderRadius.only(
  topLeft: Radius.circular(_radius),
  topRight: Radius.circular(_radius),
);
var borderRadiusBottom = BorderRadius.only(
  bottomLeft: Radius.circular(_radius),
  bottomRight: Radius.circular(_radius),
);
