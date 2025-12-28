import 'package:get_it/get_it.dart';

import '../../../features/trending/data/repositories/tokens_repo_impl.dart';
import '../../../features/trending/data/sources/tokens_remote_source.dart';
import '../../../features/trending/domain/repositories/tokens_repo.dart';
import '../../../features/trending/domain/usecases/fetch_realtime_usecase.dart';
import '../../../features/trending/domain/usecases/fetch_tokens_usecase.dart';
import '../../../features/trending/presentation/cubits/tokens/tokens_cubit.dart';
import '../module_repo.dart';

class TrendingModule implements InjectionModule {
  final GetIt _sl;

  TrendingModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => TokensRemoteSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton<TokensRepo>(() => TokensRepoImpl(_sl()));

    /// Use cases
    _sl.registerLazySingleton(() => FetchRealtimeUsecase(_sl()));

    _sl.registerLazySingleton(() => FetchTokensUsecase(_sl()));

    /// Cubits
    _sl.registerFactory(() => TokensCubit(_sl(), _sl()));
  }
}
