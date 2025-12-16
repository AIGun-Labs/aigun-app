import 'package:logger/logger.dart';

import '../../core/services/logger_service.dart';

const bool kIsProduction = bool.fromEnvironment('dart.vm.product');

class LoggerServiceImpl implements LoggerService {
  LoggerServiceImpl() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: kIsProduction ? 0 : 2,
        errorMethodCount: 8,
        lineLength: 120,
        dateTimeFormat: kIsProduction
            ? DateTimeFormat.none
            : DateTimeFormat.onlyTimeAndSinceStart,
      ),
      filter: kIsProduction ? ProductionFilter() : DevelopmentFilter(),
    );
  }
  late final Logger _logger;

  @override
  void debug(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.d(_wrap(message, tag), error: error, stackTrace: stackTrace);
  }

  @override
  void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.e(_wrap(message, tag), error: error, stackTrace: stackTrace);
  }

  @override
  void info(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.i(_wrap(message, tag), error: error, stackTrace: stackTrace);
  }

  @override
  void warning(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.w(_wrap(message, tag), error: error, stackTrace: stackTrace);
  }

  String _wrap(String msg, String? tag) {
    if (tag == null) return msg;
    return '[$tag] $msg';
  }
}
