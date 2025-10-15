import '../entities/update_info.dart';

abstract class UpdateConfigRepository {
  Future<UpdateInfo?> fetchLatest();
}
