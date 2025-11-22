import 'package:flutter/services.dart';

import '../../domain/services/installer_service.dart';

class InstallerServiceImpl implements InstallerService {
  static const _ch = MethodChannel('app.updater/install');

  @override
  Future<bool> canRequestPackageInstalls() async {
    final ok = await _ch.invokeMethod<bool>('canRequestPackageInstalls');
    return ok ?? false;
  }

  @override
  Future<void> installApk(String apkPath) async {
    await _ch.invokeMethod('install', {'path': apkPath});
  }

  @override
  Future<void> openUnknownSourcesSettings() => _ch.invokeMethod('openSettings');
}
