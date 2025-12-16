abstract interface class LoggerService {
  void debug(String message, {String? tag, Object? error, StackTrace? stackTrace});
  void info(String message, {String? tag, Object? error, StackTrace? stackTrace});
  void warning(String message, {String? tag, Object? error, StackTrace? stackTrace});
  void error(String message, {String? tag, Object? error, StackTrace? stackTrace});
}
