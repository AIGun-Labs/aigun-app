import 'package:flutter_aigun/config/env/env.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:get_it/get_it.dart';

import '../../models/upgrade/latest.dart';

class UpgradeApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  final EnvConfig _envConfig = EnvConfig();

  String get latestJsonUrl => "${_envConfig.cdn}/apk/aigun/latest.json";

  Future<Latest> getLatest() async {
    final response = await _dioClient.get(latestJsonUrl);
    return Latest.fromJson(response);
  }
}
