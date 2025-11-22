import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/update/data/repositories/apk_download_repo_impl.dart';
import '../../../features/update/data/repositories/update_config_impl.dart';
import '../../../features/update/data/services/crypto_checksum.dart';
import '../../../features/update/data/services/method_channel_installer_service.dart';
import '../../../features/update/data/sources/update_remote_source.dart';
import '../../../features/update/domain/usecases/can_install_from_unknown_sources.dart';
import '../../../features/update/domain/usecases/check_for_update.dart';
import '../../../features/update/domain/usecases/download_update.dart';
import '../../../features/update/domain/usecases/installer_apk.dart';
import '../../../features/update/domain/usecases/open_install_settings.dart';
import '../../../features/update/domain/usecases/verify_checksum.dart';
import '../../../features/update/presentation/cubits/update_cubit.dart';
import '../module_repo.dart';

class UpdateModule implements InjectionModule {
  final GetIt _sl;

  UpdateModule(this._sl);

  @override
  Future<void> init() async {
    ///Data sources
    _sl.registerLazySingleton(() => UpdateRemoteSource(Dio()));

    ///Repositories
    _sl.registerLazySingleton(() => UpdateConfigRepositoryImpl(_sl()));

    _sl.registerLazySingleton(() => ApkDownloadRepositoryImpl());

    ///Services
    _sl.registerLazySingleton(() => CryptoChecksumService());

    _sl.registerLazySingleton(() => MethodChannelInstallerService());

    ///Use cases
    _sl.registerLazySingleton(() => CheckForUpdate(_sl()));

    _sl.registerLazySingleton(() => DownloadUpdate(_sl()));

    _sl.registerLazySingleton(() => VerifyChecksum(_sl(), _sl()));

    _sl.registerLazySingleton(() => InstallerApk(_sl()));

    _sl.registerLazySingleton(() => CanInstallFromUnknownSources(_sl()));

    _sl.registerLazySingleton(() => OpenInstallSettings(_sl()));

    ///Cubits
    _sl.registerLazySingleton(
        () => UpdateCubit(_sl(), _sl(), _sl(), _sl(), _sl(), _sl()));
  }
}
