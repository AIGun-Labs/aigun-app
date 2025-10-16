import '../services/installer.dart';

class CanInstallFromUnkownSources {
  final InstallerService service;

  CanInstallFromUnkownSources(this.service);

  Future<bool> call() => service.canRequestPackageInstalls();
}
