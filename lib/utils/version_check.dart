import 'package:package_info_plus/package_info_plus.dart';

class UpdateDecision {
  final bool hasUpdate;
  final bool force;

  UpdateDecision(this.hasUpdate, this.force);
}

Future<UpdateDecision> decide(
    {required int latestBuild, String? minSupported}) async {
  final info = await PackageInfo.fromPlatform();
  final currentBuild = int.tryParse(info.buildNumber) ?? 0;
  final hasUpdate = latestBuild > currentBuild;
  final force =
      minSupported != null && _cmpSemver(info.version, minSupported) < 0;

  return UpdateDecision(hasUpdate, force);
}

int _cmpSemver(String a, String b) {
  List<int> pa =
      a.split('-').first.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  List<int> pb =
      b.split('-').first.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  for (var i = 0; i < 3; i++) {
    final d = (pa.length > i ? pa[i] : 0) - (pb.length > i ? pb[i] : 0);
    if (d != 0) return d;
  }
  return 0;
}
