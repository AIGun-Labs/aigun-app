import 'package:flutter_aigun/utils/version_compare.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../entities/update_info.dart';
import '../repositories/update_config.dart';

class CheckForUpdate {
  final UpdateConfigRepository repo;
  CheckForUpdate(this.repo);

  /// 返回：null 表示无更新；否则返回最新信息（含强更判定需由上层结合 minVersion 比对）
  Future<UpdateInfo?> call() async {
    final latestInfo = await repo.fetchLatest();
    if (latestInfo == null) return null;
    final info = await PackageInfo.fromPlatform();
    final curBuild = int.tryParse(info.buildNumber) ?? 0;
    //更新判定条件：当前版本号小于最新版本号,同时当前构建号小于最新构建号
    final hasUpdate = (curBuild < latestInfo.build) &&
        (compareSemver(info.version, latestInfo.latest) < 0);
    return hasUpdate ? latestInfo : null;
  }
}
