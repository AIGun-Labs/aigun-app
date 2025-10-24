import '../services/installer.dart';

class OpenInstallSettings {
  final InstallerService service;
  OpenInstallSettings(this.service);

  Future<void> call() => service.openUnknownSourcesSettings();
}
