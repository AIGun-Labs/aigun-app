import 'package:dio/dio.dart';

import '../../../../config/app_config.dart';
import '../../../../core/constant/enviroment.dart';
import '../models/config_model.dart';

class UpdateRemoteSource {
  UpdateRemoteSource(this._dio);

  final Dio _dio;

  //根据环境判断版本信息文件的下载地址
  static final String _env = AppConfig().envString;

  final String _s3DownloadUrl = 'https://cdn.route.aigun.ai';

  String _checksumUrl = '';

  String get latestJsonUrl {
    if (_env.isEmpty) {
      return '';
    }

    if (_env == Enviroment.production) {
      return '$_s3DownloadUrl/apk/latest.json';
    }

    return '$_s3DownloadUrl/apk-test/latest.json';
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

  Future<ConfigModel> fetchLatestInfoV2(String host) async {
    //host 去除最后的.
    final hostWithoutDot = host.endsWith('.')
        ? host.substring(0, host.length - 1)
        : host;
    final baseUrl = 'https://$hostWithoutDot';

    String downloadUrl = '$baseUrl/apk/latest.json';
    if (_env == Enviroment.production) {
      downloadUrl = '$baseUrl/apk/latest.json';
    } else {
      downloadUrl = '$baseUrl/apk-test/latest.json';
    }
    print('downloadUrl: $downloadUrl');
    try {
      final r = await _dio.get(
        downloadUrl,
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
        options: Options(headers: {'Accept': 'application/json'}),
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
