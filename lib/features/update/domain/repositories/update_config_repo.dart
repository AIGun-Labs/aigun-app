import '../entities/config_entity.dart';

abstract class UpdateConfigRepository {
  Future<ConfigEntity?> fetchLatest();

  Future<String> fetchChecksum();
}
