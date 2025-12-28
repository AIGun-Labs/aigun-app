abstract class InstallerService {
  Future<bool> canRequestPackageInstalls();
  Future<void> openUnknownSourcesSettings();
  Future<void> installApk(String apkPath);
}
