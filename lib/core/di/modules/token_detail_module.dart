import 'package:get_it/get_it.dart';

import '../../../features/token_detail/data/repositories/token_detail_repo_impl.dart';
import '../../../features/token_detail/data/sources/token_detail_remote_source.dart';
import '../../../features/token_detail/domain/repositories/token_detail_repo.dart';
import '../../../features/token_detail/domain/usecases/fetch_token_detail_info.dart';
import '../../../features/token_detail/presentation/cubits/token_info/token_info_cubit.dart';
import '../module_repo.dart';

class TokenDetailModule implements InjectionModule {
  final GetIt _sl;

  TokenDetailModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => TokenDetailRemoteSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton<TokenDetailRepo>(
      () => TokenDetailRepoImpl(_sl()),
    );

    /// Use cases
    _sl.registerLazySingleton(() => FetchTokenDetailInfo(_sl()));

    /// Cubits
    _sl.registerFactory(() => TokenInfoCubit(_sl()));
  }
}
