import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/utils/version_compare.dart';
import '../entities/config_entity.dart';
import '../repositories/update_config_repo.dart';

class CheckForUpdate {
  final UpdateConfigRepo repo;
  CheckForUpdate(this.repo);

  /// 返回：null 表示无更新；否则返回最新信息（含强更判定需由上层结合 minVersion 比对）
  /// 先忽略构建号判断，因为构建号不准确
  Future<ConfigEntity?> call() async {
    final latestInfo = await repo.fetchLatest();
    if (latestInfo == null) return null;
    final info = await PackageInfo.fromPlatform();
    // final curBuild = int.tryParse(info.buildNumber) ?? 0;
    //更新判定条件：当前版本号小于最新版本号
    final hasUpdate = (compareSemver(info.version, latestInfo.latest) < 0);
    return hasUpdate ? latestInfo : null;
  }
}
