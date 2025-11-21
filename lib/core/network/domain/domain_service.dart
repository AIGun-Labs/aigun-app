import 'dart:async';

import 'package:dio/dio.dart';

import '../../../config/env/env.dart';
import '../../../utils/logger.dart';
import 'domain_config.dart';

class DomainService {
  /// 寻找最快的可用域名
  /// [timeout] 单个检测的超时时间，默认 3 秒，太慢的直接放弃
  static Future<String> pickFastestDomain(
      {Duration timeout = const Duration(seconds: 3)}) async {
    // 1. 获取当前环境的域名列表
    final isProd = EnvConfig.currentEnvType == EnvType.production;
    final domains = isProd ? DomainConfig.prodDomains : DomainConfig.devDomains;

    if (domains.isEmpty) throw Exception('domains is empty');
    if (domains.length == 1) return domains.first;

    // 2. 创建 Dio 实例用于检测（不使用全局 Dio，避免拦截器干扰）
    final pingDio = Dio(BaseOptions(
      connectTimeout: timeout,
      receiveTimeout: timeout,
      sendTimeout: timeout,
    ));

    // 3. 核心赛马逻辑：使用 Completer 来捕获第一个成功的结果
    final completer = Completer<String>();
    int failureCount = 0;

    for (final domain in domains) {
      Logger.info('Checking domain: $domain');
      // 并发执行检测任务
      _checkDomain(pingDio, domain).then((isOk) {
        if (completer.isCompleted) return;

        if (isOk) {
          completer.complete(domain); // 第一个成功的，直接胜出！
        } else {
          Logger.error('Domain $domain is not available');
          failureCount++;
          // 如果所有域名都失败了
          if (failureCount == domains.length && !completer.isCompleted) {
            completer.completeError(Exception('domains are not available'));
          }
        }
      });
    }

    return completer.future;
  }

  /// 检测单个域名是否存活
  /// 建议后端提供一个极其轻量的接口，/api/v1/status
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
