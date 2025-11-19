import 'package:get_it/get_it.dart';

import '../../../cubits/user/user_cubit.dart' show UserCubit;
import '../../../data/services/http/dio_client.dart';
import '../../../features/collect/data/repositories/collect_repository_impl.dart';
import '../../../features/collect/data/sources/collect_remote_source.dart';
import '../../../features/collect/domain/repositories/collect_repository.dart';
import '../../../features/collect/domain/usecases/fetch_add_collect.dart';
import '../../../features/collect/domain/usecases/fetch_collect_tokens.dart';
import '../../../features/collect/domain/usecases/fetch_delete_collect.dart';
import '../../../features/collect/domain/usecases/fetch_pin_collect.dart';
import '../../../features/collect/presentation/cubits/collect_cubit.dart';
import '../../../utils/storage/local/wallet_storage.dart';
import '../module_repo.dart';

class CollectModule implements InjectionModule {
  final GetIt _sl;

  CollectModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton<CollectRemoteSource>(
        () => CollectRemoteSource(_sl<DioClient>()));

    /// Repositories
    _sl.registerLazySingleton<CollectRepository>(
        () => CollectRepositoryImpl(_sl<CollectRemoteSource>()));

    /// Use cases
    _sl.registerLazySingleton<FetchCollectTokens>(
        () => FetchCollectTokens(_sl<CollectRepository>()));
    _sl.registerLazySingleton<FetchAddCollect>(
        () => FetchAddCollect(_sl<CollectRepository>()));
    _sl.registerLazySingleton<FetchDeleteCollect>(
        () => FetchDeleteCollect(_sl<CollectRepository>()));
    _sl.registerLazySingleton<FetchPinCollect>(
        () => FetchPinCollect(_sl<CollectRepository>()));

    /// Cubits
    _sl.registerLazySingleton<CollectCubit>(() => CollectCubit(
        _sl<FetchCollectTokens>(),
        _sl<FetchAddCollect>(),
        _sl<FetchDeleteCollect>(),
        _sl<FetchPinCollect>(),
        _sl<WalletStorage>(),
        _sl<UserCubit>()));
  }
}
