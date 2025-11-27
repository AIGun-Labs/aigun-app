import '../entities/config_entity.dart';

abstract class UpdateConfigRepo {
  Future<ConfigEntity?> fetchLatest();

  Future<ConfigEntity?> fetchLatestInfoV2(String host);

  Future<String> fetchChecksum();
}
