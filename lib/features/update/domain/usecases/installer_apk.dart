import '../services/installer_service.dart';

class InstallerApk {
  final InstallerService service;
  InstallerApk(this.service);

  Future<void> call(String apkPath) => service.installApk(apkPath);
}
