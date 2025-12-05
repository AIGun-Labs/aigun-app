import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Logger {
  const Logger._();

  static const String _reset = '\x1B[0m';
  static const String _bold = '\x1B[1m';

  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';
  static const String _gray = '\x1B[90m';

  static bool get enableColors {
    const envValue = String.fromEnvironment(
      'ENABLE_LOG_COLORS',
      defaultValue: '',
    );
    if (envValue.isNotEmpty) {
      if (envValue.toLowerCase() == 'true' || envValue == '1') {
        return true;
      } else if (envValue.toLowerCase() == 'false' || envValue == '0') {
        return false;
      }
    }

    return _detectAnsiSupport();
  }

  static bool _detectAnsiSupport() {
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        return false;
      }

      if (stdout.hasTerminal) {
        try {
          final supportsAnsi = (stdout as dynamic).supportsAnsiEscapes;
          if (supportsAnsi == true) {
            return true;
          }
          if (supportsAnsi == false) {
            return false;
          }
        } catch (_) {}
      }

      if (!Platform.isWindows) {
        final term = Platform.environment['TERM'];
        if (term != null && term.isNotEmpty) {
          if (term.toLowerCase() == 'dumb') {
            return false;
          }

          return true;
        }
      }

      if (Platform.isWindows) {
        return false;
      }

      return !Platform.isIOS && !Platform.isAndroid;
    } catch (e) {
      return false;
    }
  }

  static bool get _shouldLog {
    return !kReleaseMode;
  }

  static String get _platform {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  static String get _currentTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  static String _getCallerInfo() {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split('\n');

      if (frames.length > 3) {
        final callerFrame = frames[3];

        final match = RegExp(
          r'#\d+\s+(.+)\s+\((.+):(\d+):\d+\)',
        ).firstMatch(callerFrame);

        if (match != null) {
          final fullMethod = match.group(1)?.trim() ?? '';
          final filePath = match.group(2) ?? '';
          final lineNumber = match.group(3) ?? '';

          final fileName = filePath.split('/').last.replaceAll('.dart', '');

          String displayName;
          if (fullMethod.contains('.')) {
            final parts = fullMethod.split('.');
            if (parts.length >= 2) {
              displayName = '${parts[parts.length - 2]}.${parts.last}';
            } else {
              displayName = fullMethod;
            }
          } else {
            displayName = '$fileName.$fullMethod';
          }

          return '$displayName Line:$lineNumber';
        }
      }
    } catch (e) {}

    return 'Unknown';
  }

  static String _getColorForLevel(String level) {
    if (!enableColors) return '';

    switch (level) {
      case 'DEBUG':
        return _cyan;
      case 'INFO':
        return _green;
      case 'WARN':
        return _yellow;
      case 'ERROR':
        return '$_bold$_red';
      case 'NETWORK':
        return _magenta;
      case 'VERBOSE':
        return _gray;
      default:
        return _white;
    }
  }

  static String _formatCallerInfo(String callerInfo) {
    if (!enableColors) return callerInfo;

    final parts = callerInfo.split(' Line:');
    if (parts.length == 2) {
      final methodPart = parts[0]; // ClassName.methodName
      final linePart = parts[1]; // 123

      if (methodPart.contains('.')) {
        final methodParts = methodPart.split('.');
        if (methodParts.length >= 2) {
          final className = methodParts[methodParts.length - 2];
          final methodName = methodParts.last;

          return '$_cyan$className$_reset.$_gray$methodName$_reset ${_yellow}Line:$linePart$_reset';
        }
      }

      return '$_gray$methodPart$_reset ${_yellow}Line:$linePart$_reset';
    }

    return '$_gray$callerInfo$_reset';
  }

  static void _log(
    String level,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog) return;

    final callerInfo = _getCallerInfo();
    final time = _currentTime;
    final platform = _platform;

    final color = _getColorForLevel(level);
    final reset = enableColors ? _reset : '';

    final timeColor = enableColors ? _gray : '';
    final levelColor = color;
    final formattedCaller = _formatCallerInfo(callerInfo);

    final logMessage =
        '$timeColor[$time]$reset'
        '$levelColor[$level]$reset'
        '[$platform]'
        '[$formattedCaller]: '
        '$color$message$reset';

    print(logMessage);

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

  static void debug(Object? message) {
    _log('DEBUG', message);
  }

  static void info(Object? message) {
    _log('INFO', message);
  }

  static void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    _log('ERROR', message, error: error, stackTrace: stackTrace);
  }

  static void warning(Object? message) {
    _log('WARN', message);
  }

  static void network(String message) {
    _log('NETWORK', message);
  }

  static void verbose(Object? message) {
    _log('VERBOSE', message);
  }
}
