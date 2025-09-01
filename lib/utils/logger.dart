import 'package:flutter_aigun/config/env.dart';
import 'package:logger/logger.dart' as log;

/// 日志工具类
class Logger {
  static final _logger = log.Logger(
    printer: log.PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: log.DateTimeFormat.onlyTime,
    ),
  );

  // 私有构造函数
  const Logger._();

  static void debug(Object? message) {
    if (Env.isDev) {
      _logger.d('🐛 $message');
    }
  }

  static void info(Object? message) {
    if (Env.isDev) {
      _logger.i('ℹ️ $message');
    }
  }

  static void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    if (Env.isDev) {
      _logger.e('❌ $message', error: error, stackTrace: stackTrace);
    }
  }

  static void network(String message) {
    _logger.i('[Network] $message');
  }
}
