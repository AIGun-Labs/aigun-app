import '../entities/config_entity.dart';

abstract class UpdateConfigRepository {
  Future<ConfigEntity?> fetchLatest();

  Future<ConfigEntity?> fetchLatestInfoV2(String host);

  Future<String> fetchChecksum();
}
