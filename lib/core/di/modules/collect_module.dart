import 'package:get_it/get_it.dart';

import '../../../features/collect/data/repositories/collect_repo_impl.dart';
import '../../../features/collect/data/sources/collect_remote_source.dart';
import '../../../features/collect/domain/repositories/collect_repo.dart';
import '../../../features/collect/domain/usecases/fetch_add_collect.dart';
import '../../../features/collect/domain/usecases/fetch_delete_collect.dart';
import '../../../features/collect/domain/usecases/fetch_pin_collect.dart';
import '../../../features/collect/presentation/cubits/collect_cubit.dart';
import '../../../features/trending/domain/usecases/fetch_collected_tokens_usecase.dart';
import '../module_repo.dart';

class CollectModule implements InjectionModule {
  final GetIt _sl;

  CollectModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => CollectRemoteSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton<CollectRepo>(() => CollectRepoImpl(_sl()));

    /// Use cases
    _sl.registerLazySingleton(() => FetchAddCollect(_sl()));

    _sl.registerLazySingleton(() => FetchDeleteCollect(_sl()));

    _sl.registerLazySingleton(() => FetchPinCollect(_sl()));

    _sl.registerLazySingleton(() => FetchCollectedTokensUsecase(_sl()));

    /// Cubits
    _sl.registerLazySingleton(
      () => CollectCubit(_sl(), _sl(), _sl(), _sl(), _sl(), _sl()),
    );
  }
}
