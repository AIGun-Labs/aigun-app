import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../config/app_config.dart';

/// 日志工具类
/// 格式：[日期时间][日志类型][平台][类名.函数名 Line:行]: 日志内容
class Logger {
  // 私有构造函数
  const Logger._();

  // ANSI 颜色代码
  static const String _reset = '\x1B[0m';
  static const String _bold = '\x1B[1m';

  // 文字颜色
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';
  static const String _gray = '\x1B[90m';

  // 是否启用颜色（由编译时的 dart-define 控制，默认开启）
  // 使用方法：flutter run --dart-define=ENABLE_LOG_COLORS=false ...
  // 如果未明确设置，会自动检测终端是否支持 ANSI 颜色
  static bool get enableColors {
    // 1. 首先检查是否通过环境变量明确设置
    const envValue = String.fromEnvironment(
      'ENABLE_LOG_COLORS',
      defaultValue: '',
    );
    if (envValue.isNotEmpty) {
      // 如果明确设置了，使用设置的值
      if (envValue.toLowerCase() == 'true' || envValue == '1') {
        return true;
      } else if (envValue.toLowerCase() == 'false' || envValue == '0') {
        return false;
      }
      // 如果值不明确，继续自动检测
    }

    // 2. 如果未明确设置，自动检测终端支持
    return _detectAnsiSupport();
  }

  /// 检测终端是否支持 ANSI 颜色代码
  static bool _detectAnsiSupport() {
    try {
      // 方法 1: 移动平台（iOS/Android）通常不支持 ANSI 颜色
      // 在 Flutter 中，移动设备的控制台输出不支持 ANSI 转义序列
      if (Platform.isIOS || Platform.isAndroid) {
        return false;
      }

      // 方法 2: 检查 stdout 是否支持 ANSI 转义序列（在支持的平台上）
      if (stdout.hasTerminal) {
        // 在 Dart 2.10+ 中，可以使用 supportsAnsiEscapes
        // 使用动态调用以避免在旧版本 Dart 中编译错误
        try {
          // 通过反射检查 supportsAnsiEscapes 属性
          final supportsAnsi = (stdout as dynamic).supportsAnsiEscapes;
          if (supportsAnsi == true) {
            return true;
          }
          if (supportsAnsi == false) {
            return false;
          }
        } catch (_) {
          // 如果属性不存在或访问失败，继续使用其他检测方法
        }
      }

      // 方法 3: 检查 TERM 环境变量（Unix/Linux/macOS）
      if (!Platform.isWindows) {
        final term = Platform.environment['TERM'];
        if (term != null && term.isNotEmpty) {
          // 如果 TERM 是 'dumb' 或空，不支持颜色
          if (term.toLowerCase() == 'dumb') {
            return false;
          }
          // 其他情况通常支持颜色（如 xterm, xterm-256color, screen 等）
          return true;
        }
      }

      // 方法 4: Windows 10+ 支持 ANSI 颜色（通过 ConPTY）
      if (Platform.isWindows) {
        // Windows 10 1607+ 支持 ANSI，但检测较复杂
        // 默认返回 false，因为旧版本 Windows 不支持
        return false;
      }

      // 默认情况：桌面平台假设支持，移动平台不支持
      return !Platform.isIOS && !Platform.isAndroid;
    } catch (e) {
      // 如果检测失败，保守地返回 false（避免显示转义字符）
      return false;
    }
  }

  /// 判断是否应该打印日志
  /// 生产环境（Release 模式）不打印任何日志
  static bool get _shouldLog {
    // 1. 使用 Flutter 的 kReleaseMode 判断
    // 2. 使用项目的 AppConfig().env.isDev 判断
    // 只有在 Debug 模式下才打印日志
    return !kReleaseMode && AppConfig().env.isDev;
  }

  /// 获取平台信息
  static String get _platform {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  /// 获取当前时间字符串
  static String get _currentTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  /// 获取调用栈信息（类名、方法名、行号）
  static String _getCallerInfo() {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split('\n');

      // 跳过 Logger 类自身的调用栈
      // 通常第 0 行是 StackTrace.current
      // 第 1 行是 _getCallerInfo
      // 第 2 行是 debug/info/error 等方法
      // 第 3 行才是真正的调用者
      if (frames.length > 3) {
        final callerFrame = frames[3];

        // 解析栈帧信息
        // 格式通常是：#3      ClassName.methodName (file:///path/to/file.dart:123:45)
        final match = RegExp(
          r'#\d+\s+(.+)\s+\((.+):(\d+):\d+\)',
        ).firstMatch(callerFrame);

        if (match != null) {
          final fullMethod = match.group(1)?.trim() ?? '';
          final filePath = match.group(2) ?? '';
          final lineNumber = match.group(3) ?? '';

          // 提取文件名（不含路径）
          final fileName = filePath.split('/').last.replaceAll('.dart', '');

          // 提取类名和方法名
          String displayName;
          if (fullMethod.contains('.')) {
            // 格式：ClassName.methodName 或 package.ClassName.methodName
            final parts = fullMethod.split('.');
            if (parts.length >= 2) {
              // 取最后两部分（类名.方法名）
              displayName = '${parts[parts.length - 2]}.${parts.last}';
            } else {
              displayName = fullMethod;
            }
          } else {
            // 如果没有类名，使用文件名
            displayName = '$fileName.$fullMethod';
          }

          return '$displayName Line:$lineNumber';
        }
      }
    } catch (e) {
      // 解析失败时返回默认值
    }

    return 'Unknown';
  }

  /// 获取日志级别对应的颜色
  static String _getColorForLevel(String level) {
    if (!enableColors) return '';

    switch (level) {
      case 'DEBUG':
        return _cyan; // 青色
      case 'INFO':
        return _green; // 绿色
      case 'WARN':
        return _yellow; // 黄色
      case 'ERROR':
        return '$_bold$_red'; // 加粗红色
      case 'NETWORK':
        return _magenta; // 紫色
      case 'VERBOSE':
        return _gray; // 灰色
      default:
        return _white;
    }
  }

  /// 格式化调用信息，给文件名/类名和行号添加颜色
  static String _formatCallerInfo(String callerInfo) {
    if (!enableColors) return callerInfo;

    // 分离类名.方法名和行号
    // 格式：ClassName.methodName Line:123
    final parts = callerInfo.split(' Line:');
    if (parts.length == 2) {
      final methodPart = parts[0]; // ClassName.methodName
      final linePart = parts[1]; // 123

      // 进一步分离类名和方法名
      if (methodPart.contains('.')) {
        final methodParts = methodPart.split('.');
        if (methodParts.length >= 2) {
          final className = methodParts[methodParts.length - 2]; // 类名
          final methodName = methodParts.last; // 方法名

          // 类名用青色，方法名用灰色，Line:行号用黄色高亮
          return '$_cyan$className$_reset.$_gray$methodName$_reset ${_yellow}Line:$linePart$_reset';
        }
      }

      // 如果没有点号，整体用灰色
      return '$_gray$methodPart$_reset ${_yellow}Line:$linePart$_reset';
    }

    return '$_gray$callerInfo$_reset';
  }

  /// 格式化日志输出
  static void _log(
    String level,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    // 生产环境不打印任何日志
    if (!_shouldLog) return;

    final callerInfo = _getCallerInfo();
    final time = _currentTime;
    final platform = _platform;

    // 获取颜色
    final color = _getColorForLevel(level);
    final reset = enableColors ? _reset : '';

    // 格式：[日期时间][日志类型][平台][类名.函数名 Line:行]: 日志内容
    // 时间用灰色，日志级别用对应颜色，平台不加颜色，调用信息中行号用黄色
    final timeColor = enableColors ? _gray : '';
    final levelColor = color;
    final formattedCaller = _formatCallerInfo(callerInfo);

    final logMessage =
        '$timeColor[$time]$reset'
        '$levelColor[$level]$reset'
        '[$platform]'
        '[$formattedCaller]: '
        '$color$message$reset';

    // 使用 print 输出，确保在所有平台都能看到
    print(logMessage);

    // 如果有错误信息，也打印出来
    if (error != null) {
      final errorColor = enableColors ? '$_bold$_red' : '';
      print(
        '$timeColor[$time]$reset'
        '$levelColor[$level]$reset'
        '[$platform]'
        '[$formattedCaller]: '
        '${errorColor}Error: $error$reset',
      );
    }

    // 如果有堆栈信息，打印堆栈
    if (stackTrace != null) {
      final stackColor = enableColors ? _gray : '';
      print(
        '$timeColor[$time]$reset'
        '$levelColor[$level]$reset'
        '[$platform]'
        '[$formattedCaller]: '
        '${stackColor}StackTrace:\n$stackTrace$reset',
      );
    }
  }

  /// Debug 日志
  static void debug(Object? message) {
    _log('DEBUG', message);
  }

  /// Info 日志
  static void info(Object? message) {
    _log('INFO', message);
  }

  /// Error 日志
  static void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    _log('ERROR', message, error: error, stackTrace: stackTrace);
  }

  /// Warning 日志
  static void warning(Object? message) {
    _log('WARN', message);
  }

  /// Network 日志
  static void network(String message) {
    _log('NETWORK', message);
  }

  /// Verbose 日志（详细日志）
  static void verbose(Object? message) {
    _log('VERBOSE', message);
  }
}
