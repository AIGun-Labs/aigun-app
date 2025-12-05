import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../network/dio_client.dart';
import '../network/domain/domain_service.dart';
import '../network/gatekeeper/gate_keeper_service.dart';

final newGetIt = GetIt.instance;
Future<void> initCore() async {
  newGetIt.registerLazySingleton(() => const FlutterSecureStorage());

  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = AppConfig.baseApiUrl;
  }

  newGetIt.registerSingleton(GateKeeperService(baseUrl));

  newGetIt.registerSingleton(
    NewDioClient(newGetIt(), newGetIt(), baseUrl: baseUrl),
  );
}

Future reset() async {
  newGetIt.reset();
}
