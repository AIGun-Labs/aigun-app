import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../config/doh_endpoint.dart';

class DownloadDnsRemoteSource {
  final _client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  static const String _defaultCname = 'cdn.route.aigun.ai';

  final List<DohEndpoint> _dohEndpoints = [
    DohEndpoint.alidns(),
    DohEndpoint.google(),
    DohEndpoint.cloudflare(),
  ];

  static const String _downloadDomain = 'download.route.aigun.ai';

  Future<String> getCname() async {
    for (final endpoint in _dohEndpoints) {
      try {
        final cname = await _getCnameFromEndpoint(endpoint, _downloadDomain);
        if (cname != null) {
          return cname;
        }
      } catch (e) {
        continue;
      }
    }
    return _defaultCname;
  }

  Future<String?> _getCnameFromEndpoint(
      DohEndpoint endpoint, String host) async {
    final response = await _client.get(
      endpoint.baseUrl,
      queryParameters: {
        'name': host,
        'type': 'CNAME',
      },
      options: Options(
        headers: endpoint.headers,
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode != 200) {
      return null;
    }

    final data = response.data;

    final Map<String, dynamic> jsonMap;

    if (data is Map<String, dynamic>) {
      jsonMap = data;
    } else if (data is String) {
      jsonMap = json.decode(data) as Map<String, dynamic>;
    } else {
      return null;
    }

    final status = jsonMap['Status'] as int?;

    if (status != 0) {
      return null;
    }

    final answers = jsonMap['Answer'];
    if (answers is! List) {
      return null;
    }

    for (final item in answers) {
      if (item is Map<String, dynamic>) {
        final type = item['type'] as int?;
        final data = item['data'] as String?;
        // type 5 = CNAME
        if (type == 5 && data != null) {
          return data;
        }
      }
    }

    return null;
  }

  void dispose() {
    _client.close();
  }
}
