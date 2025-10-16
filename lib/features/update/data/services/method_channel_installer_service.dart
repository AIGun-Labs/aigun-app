import 'package:flutter/services.dart';

import '../../domain/services/installer.dart';

class MethodChannelInstallerService implements InstallerService {
  static const _ch = MethodChannel('app.updater/install');

  @override
  Future<bool> canRequestPackageInstalls() async {
    final ok = await _ch.invokeMethod<bool>('canRequestPackageInstalls');
    return ok ?? true;
  }

  @override
  Future<void> installApk(String apkPath) async {
    await _ch.invokeMethod('install', {'path': apkPath});
  }

  @override
  Future<void> openUnknownSourcesSettings() => _ch.invokeMethod('openSettings');
}
