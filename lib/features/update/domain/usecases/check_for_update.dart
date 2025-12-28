import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/utils/version_compare.dart';
import '../entities/config_entity.dart';
import '../repositories/update_config_repo.dart';

@Deprecated('use CheckForUpdateV2 usecase')
class CheckForUpdate {
  final UpdateConfigRepo repo;
  CheckForUpdate(this.repo);
  Future<ConfigEntity?> call() async {
    final latestInfo = await repo.fetchLatest();
    if (latestInfo == null) return null;
    final info = await PackageInfo.fromPlatform();
    // final curBuild = int.tryParse(info.buildNumber) ?? 0;
    final hasUpdate = (compareSemver(info.version, latestInfo.latest) < 0);
    return hasUpdate ? latestInfo : null;
  }
}
