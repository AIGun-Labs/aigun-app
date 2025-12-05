import 'dart:async';

import 'package:dio/dio.dart';

import '../../../config/app_config.dart';
import '../../../utils/logger.dart';
import 'domain_config.dart';

class DomainService {
  static Future<String> pickFastestDomain({
    Duration timeout = const Duration(seconds: 3),
  }) async {
    final isProd = AppConfig.isProd;
    final domains = isProd
        ? DomainConfig.prodDomains
        : DomainConfig.testDomains;

    if (domains.isEmpty) throw Exception('domains is empty');
    if (domains.length == 1) return domains.first;

    final pingDio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
      ),
    );

    final completer = Completer<String>();
    int failureCount = 0;

    for (final domain in domains) {
      Logger.info('Checking domain: $domain');

      _checkDomain(pingDio, domain).then((isOk) {
        if (completer.isCompleted) return;

        if (isOk) {
          completer.complete(domain);
        } else {
          Logger.error('Domain $domain is not available');
          failureCount++;

          if (failureCount == domains.length && !completer.isCompleted) {
            completer.completeError(Exception('domains are not available'));
          }
        }
      });
    }

    return completer.future;
  }

  static Future<bool> _checkDomain(Dio dio, String baseUrl) async {
    try {
      final response = await dio.get('$baseUrl/api/v1/status');
      if (response.statusCode == 200 ||
          response.data['data']['status'] == 'healthy') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
