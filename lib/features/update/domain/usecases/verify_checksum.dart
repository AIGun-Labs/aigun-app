import '../../../../utils/logger.dart';
import '../repositories/update_config_repo.dart';
import '../services/checksum_service.dart';

class VerifyChecksum {
  final ChecksumService service;
  final UpdateConfigRepository repo;
  VerifyChecksum(this.service, this.repo);

  Future<bool> call(String path) async {
    final actual = await service.sha256OfFile(path);
    final expected = await repo.fetchChecksum();
    Logger.info('path: $path');
    Logger.info('actual: $actual');
    Logger.info('expected: $expected');
    return actual.toLowerCase() == expected.toLowerCase();
  }
}
