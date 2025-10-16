import '../../domain/entities/update_info.dart';
import '../../domain/repositories/update_config.dart';
import '../sources/latest_config.dart';

class UpdateConfigRepositoryImpl implements UpdateConfigRepository {
  final LatestConfigDataSource remote;
  UpdateConfigRepositoryImpl(this.remote);

  @override
  Future<UpdateInfo?> fetchLatest() => remote.fetch();
}
