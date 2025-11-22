import 'package:get_it/get_it.dart';

import '../../../features/trending/data/repositories/hot_token_repository_impl.dart';
import '../../../features/trending/data/sources/hot_token_remote_source.dart';
import '../../../features/trending/domain/usecases/fetch_hot_tokens.dart';
import '../../../features/trending/domain/usecases/fetch_networks.dart';
import '../../../features/trending/presentation/cubits/hot_token_cubit.dart';
import '../module_repo.dart';

/// Trending 模块依赖注入配置
class TrendingModule implements InjectionModule {
  final GetIt _sl;

  TrendingModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(
      () => HotTokenRemoteSource(_sl()),
    );

    /// Repositories
    _sl.registerLazySingleton(
      () => HotTokenRepositoryImpl(_sl()),
    );

    /// Use cases
    _sl.registerLazySingleton(
      () => FetchHotTokens(_sl()),
    );

    _sl.registerLazySingleton(
      () => FetchNetworks(_sl()),
    );

    /// Cubits
    _sl.registerLazySingleton(
      () => HotTokenCubit(
        _sl(),
        _sl(),
      ),
    );
  }
}
