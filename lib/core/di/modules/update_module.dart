import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/update/data/repositories/apk_download.dart';
import '../../../features/update/data/repositories/update_config.dart';
import '../../../features/update/data/services/crypto_checksum.dart';
import '../../../features/update/data/services/method_channel_installer_service.dart';
import '../../../features/update/data/sources/latest_config.dart';
import '../../../features/update/domain/repositories/apk_download.dart';
import '../../../features/update/domain/repositories/update_config.dart';
import '../../../features/update/domain/services/checksum.dart';
import '../../../features/update/domain/services/installer.dart';
import '../../../features/update/domain/usecases/can_install_from_unkown_sources.dart';
import '../../../features/update/domain/usecases/check_for_update.dart';
import '../../../features/update/domain/usecases/download_update.dart';
import '../../../features/update/domain/usecases/installer_apk.dart';
import '../../../features/update/domain/usecases/open_install_settings.dart';
import '../../../features/update/domain/usecases/verify_checksum.dart';
import '../../../features/update/presentation/cubit/update_cubit.dart';
import '../module_repo.dart';

class UpdateModule implements InjectionModule {
  final GetIt _sl;

  UpdateModule(this._sl);

  @override
  Future<void> init() async {
    ///Data sources
    _sl.registerLazySingleton<LatestConfigDataSource>(
        () => LatestConfigDataSource(Dio()));

    ///Repositories
    _sl.registerLazySingleton<UpdateConfigRepository>(
        () => UpdateConfigRepositoryImpl(_sl<LatestConfigDataSource>()));
    _sl.registerLazySingleton<ApkDownloadRepository>(
        () => ApkDownloadRepositoryImpl());

    ///Services
    _sl.registerLazySingleton<ChecksumService>(() => CryptoChecksumService());
    _sl.registerLazySingleton<InstallerService>(
        () => MethodChannelInstallerService());

    ///Use cases
    _sl.registerLazySingleton(
        () => CheckForUpdate(_sl<UpdateConfigRepository>()));
    _sl.registerLazySingleton(
        () => DownloadUpdate(_sl<ApkDownloadRepository>()));
    _sl.registerLazySingleton(() => VerifyChecksum(_sl<ChecksumService>()));
    _sl.registerLazySingleton(() => InstallerApk(_sl<InstallerService>()));
    _sl.registerLazySingleton(
        () => CanInstallFromUnkownSources(_sl<InstallerService>()));
    _sl.registerLazySingleton(
        () => OpenInstallSettings(_sl<InstallerService>()));

    ///Cubits
    _sl.registerLazySingleton(() => UpdateCubit(
        _sl<CheckForUpdate>(),
        _sl<DownloadUpdate>(),
        _sl<VerifyChecksum>(),
        _sl<InstallerApk>(),
        _sl<CanInstallFromUnkownSources>(),
        _sl<OpenInstallSettings>()));
  }
}
