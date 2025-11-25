import 'package:get_it/get_it.dart';

import '../../../features/trending/data/repositories/top_token_repo_impl.dart';
import '../../../features/trending/data/sources/top_token_romote_source.dart';
import '../../../features/trending/domain/repositories/top_token_repo.dart';
import '../../../features/trending/domain/usecases/fetch_top_tokens.dart';
import '../../../features/trending/presentation/cubits/top_token_cubit.dart';
import '../module_repo.dart';

class TopTokenModule implements InjectionModule {
  final GetIt _sl;

  TopTokenModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(
      () => TopTokenRemoteSource(_sl()),
    );

    /// Repositories
    _sl.registerLazySingleton<TopTokenRepo>(
      () => TopTokenRepoImpl(_sl()),
    );

    /// Use cases
    _sl.registerLazySingleton(
      () => FetchTopTokens(_sl()),
    );

    /// Cubits
    _sl.registerLazySingleton(
      () => TopTokenCubit(
        _sl(),
      ),
    );
  }
}
