import '../services/installer.dart';

class CanInstallFromUnknownSources {
  final InstallerService service;

  CanInstallFromUnknownSources(this.service);

  Future<bool> call() => service.canRequestPackageInstalls();
}
