import 'package:get_it/get_it.dart';

import '../../../config/env/env.dart';
import '../../models/upgrade/latest.dart';
import '../http/dio_client.dart';

class UpgradeApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  final EnvConfig _envConfig = EnvConfig();

  String get latestJsonUrl => "${_envConfig.cdn}/apk/aigun/latest.json";

  Future<Latest> getLatest() async {
    final response = await _dioClient.get(latestJsonUrl);
    return Latest.fromJson(response);
  }
}
