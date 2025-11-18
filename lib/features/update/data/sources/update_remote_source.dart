import 'package:dio/dio.dart';

import '../../../../config/env/env.dart';
import '../models/config_model.dart';

class UpdateRemoteSource {
  UpdateRemoteSource(this._dio);

  final Dio _dio;

  final EnvConfig _envConfig = EnvConfig();

  String _checksumUrl = '';

  String get latestJsonUrl {
    const String env = String.fromEnvironment('ENV', defaultValue: '');

    if (env.isEmpty) {
      return "";
    }

    if (env.toLowerCase() == 'production') {
      return "${_envConfig.cdn}/apk/latest.json";
    }

    return "${_envConfig.cdn}/apk-test/latest.json";
  }

  Future<ConfigModel?> fetchLatestInfo() async {
    if (latestJsonUrl.isEmpty) {
      throw Exception('Config URL is empty');
    }
    try {
      final r = await _dio.get(
        latestJsonUrl,
        options: Options(
          headers: {'Accept': 'application/json'},
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 10),
        ),
      );
      if (r.statusCode == 200 && r.data is Map<String, dynamic>) {
        final updateInfo = ConfigModel.fromJson(r.data);
        _checksumUrl = '${updateInfo.url}.sha256';
        return updateInfo;
      } else {
        throw Exception('Config not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> fetchChecksum() async {
    if (_checksumUrl.isEmpty) {
      throw Exception('Checksum URL is empty');
    }

    try {
      final r = await _dio.get(
        _checksumUrl,
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );
      if (r.statusCode == 200 && r.data is String) {
        return r.data;
      } else {
        throw Exception('Checksum not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
