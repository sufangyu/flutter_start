/// 环境/构建时参数
/// --dart-define=VERSION=[1.0.0]
/// --dart-define=ENV=[test]
/// --dart-define=SWITCH_ENV=[true]
/// --dart-define=ANDROID_CHANNEL=[xiaomi]
class EnvConfig {
  static const version =
      String.fromEnvironment('VERSION', defaultValue: '1.0.0');

  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static const canSwitchEnv =
      bool.fromEnvironment('SWITCH_ENV', defaultValue: false);

  static const channel =
      String.fromEnvironment('ANDROID_CHANNEL', defaultValue: 'unknown');
}
