/// 环境/构建时参数
/// --dart-define=VERSION=[1.0.0]
/// --dart-define=ENV=[test]
/// --dart-define=SWITCH_ENV=[false]
/// --dart-define=PROXY=[false]
/// --dart-define=ANDROID_CHANNEL=[xiaomi]
class EnvConfig {
  static const version =
      String.fromEnvironment('VERSION', defaultValue: '1.0.0');

  /// 当前环境
  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');

  /// 是否可切换 API 环境
  static const canSwitchEnv =
      bool.fromEnvironment('SWITCH_ENV', defaultValue: false);

  /// 是否可代理抓包
  static const canProxy = bool.fromEnvironment('PROXY', defaultValue: false);

  /// android 渠道
  static const channel =
      String.fromEnvironment('ANDROID_CHANNEL', defaultValue: 'unknown');
}
