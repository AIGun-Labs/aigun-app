import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/update/data/repositories/apk_download_repo_impl.dart';
import '../../../features/update/data/repositories/update_config_impl.dart';
import '../../../features/update/data/services/checksum_service_impl.dart';
import '../../../features/update/data/services/installer_service_impl.dart';
import '../../../features/update/data/sources/update_remote_source.dart';
import '../../../features/update/domain/repositories/apk_download_repo.dart';
import '../../../features/update/domain/repositories/update_config_repo.dart';
import '../../../features/update/domain/services/checksum_service.dart';
import '../../../features/update/domain/services/installer_service.dart';
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
    _sl.registerLazySingleton<UpdateConfigRepository>(
        () => UpdateConfigRepositoryImpl(_sl()));

    _sl.registerLazySingleton<ApkDownloadRepository>(
        () => ApkDownloadRepositoryImpl());

    ///Services
    _sl.registerLazySingleton<ChecksumService>(() => ChecksumServiceImpl());

    _sl.registerLazySingleton<InstallerService>(() => InstallerServiceImpl());

    ///Use cases
    _sl.registerLazySingleton(() => CheckForUpdate(_sl()));

    _sl.registerLazySingleton(() => DownloadUpdate(_sl()));

    _sl.registerLazySingleton(() => VerifyChecksum(_sl(), _sl()));

    _sl.registerLazySingleton(() => InstallerApk(_sl()));

    _sl.registerLazySingleton(() => CanInstallFromUnknownSources(_sl()));

    _sl.registerLazySingleton(() => OpenInstallSettings(_sl()));

    ///Cubits
    _sl.registerSingleton(
        UpdateCubit(_sl(), _sl(), _sl(), _sl(), _sl(), _sl()));
  }
}
