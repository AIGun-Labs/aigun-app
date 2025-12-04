import 'package:get_it/get_it.dart';

import '../../../features/token_detail/data/repositories/token_detail_repo_impl.dart';
import '../../../features/token_detail/data/sources/token_detail_remote_source.dart';
import '../../../features/token_detail/domain/repositories/token_detail_repo.dart';
import '../../../features/token_detail/domain/usecases/fetch_intel_count.dart';
import '../../../features/token_detail/domain/usecases/fetch_latest_intel_v2.dart';
import '../../../features/token_detail/domain/usecases/fetch_token_detail_info.dart';
import '../../../features/token_detail/domain/usecases/fetch_token_profit.dart';
import '../../../features/token_detail/domain/usecases/fetch_token_security.dart';
import '../../../features/token_detail/domain/usecases/fetch_urls.dart';
import '../../../features/token_detail/presentation/cubits/holdings/holdings_cubit.dart';
import '../../../features/token_detail/presentation/cubits/intels/intels_cubit.dart';
import '../../../features/token_detail/presentation/cubits/latest_intel/latest_intel_cubit.dart';
import '../../../features/token_detail/presentation/cubits/token_info/token_info_cubit.dart';
import '../../../features/token_detail/presentation/cubits/token_security/token_security_cubit.dart';
import '../../../features/token_detail/presentation/cubits/urls/urls_cubit.dart';
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
      () => TokenDetailRepoImpl(_sl(), _sl()),
    );

    /// Use cases
    _sl.registerLazySingleton(() => FetchTokenDetailInfo(_sl()));
    _sl.registerLazySingleton(() => FetchLatestIntelV2(_sl()));
    _sl.registerLazySingleton(() => FetchUrls(_sl()));
    _sl.registerLazySingleton(() => FetchTokenProfit(_sl()));
    _sl.registerLazySingleton(() => FetchIntelCount(_sl()));
    _sl.registerLazySingleton(() => FetchTokenSecurity(_sl()));

    /// Cubits
    _sl.registerFactory(() => TokenInfoCubit(_sl()));
    _sl.registerFactory(() => LatestIntelCubit(_sl()));
    _sl.registerFactory(() => UrlsCubit(_sl()));
    _sl.registerFactory(() => HoldingsCubit(_sl()));
    _sl.registerFactory(() => IntelsCubit(_sl()));
    _sl.registerFactory(() => TokenSecurityCubit(_sl()));
  }
}
