import '../services/installer.dart';

class InstallerApk {
  final InstallerService service;
  InstallerApk(this.service);

  Future<void> call(String apkPath) => service.installApk(apkPath);
}
