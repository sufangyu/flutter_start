/// 环境/构建时参数
class EnvConfig {
  static const channel =
      String.fromEnvironment('ANDROID_CHANNEL', defaultValue: 'unknown');
  static const version =
      String.fromEnvironment('ANDROID_VERSION', defaultValue: '1.0.0');
  static const env = String.fromEnvironment('ANDROID_ENV', defaultValue: 'dev');
}
