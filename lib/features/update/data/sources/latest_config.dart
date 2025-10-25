import 'package:dio/dio.dart';

import '../../../../config/env/env.dart';
import '../../../../utils/logger.dart';
import '../../domain/entities/update_info.dart';

class LatestConfigDataSource {
  LatestConfigDataSource(this._dio);

  final Dio _dio;

  final EnvConfig _envConfig = EnvConfig();

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

  Future<UpdateInfo?> fetch() async {
    if (latestJsonUrl.isEmpty) {
      return null;
    }
    try {
      Logger.info('获取更新配置: $latestJsonUrl');
      final r = await _dio.get(
        latestJsonUrl,
        options: Options(
          headers: {'Accept': 'application/json'},
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 10),
        ),
      );
      if (r.statusCode == 200 && r.data is Map<String, dynamic>) {
        final updateInfo = UpdateInfo.fromJson(r.data);

        return updateInfo;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      Logger.error('获取更新配置失败: $e');
      Logger.error('堆栈跟踪: $stackTrace');
      rethrow;
    }
  }
}
