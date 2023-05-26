import 'package:amap_flutter_base/amap_flutter_base.dart';

class MapConfig {
  static const androidKey = 'f934f5448faee7b7b2290d24092f6dfc';
  static const iosKey = 'd113a36cf5227a4229f316c2ea1d5a35';
  static const webKey = '6fb0d21882c906ff501a0696bd9d7169';

  /// 构造AMapKeyConfig
  static const AMapApiKey amapApiKeys =
      AMapApiKey(iosKey: iosKey, androidKey: androidKey);

  /// 注意：[AMapPrivacyStatement]的'hasContains''hasShow''hasAgree'这三个参数中有一个为false，高德SDK均不会工作，会造成地图白屏等现象
  static const AMapPrivacyStatement amapPrivacyStatement =
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}
