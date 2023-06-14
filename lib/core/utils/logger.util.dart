import 'package:logger/logger.dart';

/// 日志工具类
class LoggerUtil {
  static final Logger _logger = Logger(
    filter: null,
    level: Level.verbose,
    printer: PrefixPrinter(PrettyPrinter(
      stackTraceBeginIndex: 0, // 方法栈的开始下标
      methodCount: 3, // 打印方法栈的个数
      errorMethodCount: 8, // 自己传入方法栈对象后该参数有效
      lineLength: 120, // 每行最多打印的字符个数
      colors: true, // 日志是否有颜色
      printEmojis: true, // 是否打印 emoji 表情
      printTime: false, // 是否打印时间
    )),
  );

  static void verbose(dynamic message) {
    _logger.v(message);
  }

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }

  static void wtf(dynamic message) {
    _logger.wtf(message);
  }
}
