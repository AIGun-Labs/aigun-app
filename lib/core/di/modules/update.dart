import 'package:get_it/get_it.dart';

import '../../../features/update/data/repositories/apk_download.dart';
import '../../../features/update/data/repositories/update_config.dart';
import '../../../features/update/data/services/crypto_checksum.dart';
import '../../../features/update/data/sources/latest_config.dart';
import '../../../features/update/domain/repositories/apk_download.dart';
import '../../../features/update/domain/repositories/update_config.dart';
import '../../../features/update/domain/services/checksum.dart';
import '../../../features/update/domain/usecases/check_for_update.dart';
import '../../../features/update/domain/usecases/download_update.dart';
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
        () => LatestConfigDataSource());

    ///Repositories
    _sl.registerLazySingleton<UpdateConfigRepository>(
        () => UpdateConfigRepositoryImpl(_sl<LatestConfigDataSource>()));
    _sl.registerLazySingleton<ApkDownloadRepository>(
        () => ApkDownloadRepositoryImpl());

    ///Services
    _sl.registerLazySingleton<ChecksumService>(() => CryptoChecksumService());

    ///Use cases
    _sl.registerLazySingleton(
        () => CheckForUpdate(_sl<UpdateConfigRepository>()));
    _sl.registerLazySingleton(
        () => DownloadUpdate(_sl<ApkDownloadRepository>()));
    _sl.registerLazySingleton(() => VerifyChecksum(_sl<ChecksumService>()));

    ///Cubits
    _sl.registerLazySingleton(() => UpdateCubit(
        _sl<CheckForUpdate>(), _sl<DownloadUpdate>(), _sl<VerifyChecksum>()));
  }
}
