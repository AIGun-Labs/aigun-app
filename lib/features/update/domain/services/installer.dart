abstract class InstallerService {
  /// 是否已具备“允许此来源安装”权限（Android 8.0+）
  Future<bool> canRequestPackageInstalls();

  /// 打开系统设置，引导用户授权“允许此来源安装”
  Future<void> openUnknownSourcesSettings();

  /// 触发系统安装器（仅代表已拉起安装器，不表示安装结果）
  /// 可能抛出 PlatformException，code: needs_permission/file_not_found/no_handler/security_error/internal_error
  Future<void> installApk(String apkPath);
}
