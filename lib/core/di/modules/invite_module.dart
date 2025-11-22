import 'package:get_it/get_it.dart';

import '../../../features/bonus/data/repositories/claim_token_repo_impl.dart';
import '../../../features/bonus/data/repositories/invite_repo_impl.dart';
import '../../../features/bonus/data/sources/claim_token_remote_source.dart';
import '../../../features/bonus/data/sources/invite_remote_source.dart';
import '../../../features/bonus/domain/usecases/claim_token.dart';
import '../../../features/bonus/domain/usecases/fetch_active_code.dart';
import '../../../features/bonus/domain/usecases/fetch_claim_gold.dart';
import '../../../features/bonus/domain/usecases/fetch_invite_info.dart';
import '../../../features/bonus/domain/usecases/fetch_realtime_funds.dart';
import '../../../features/bonus/domain/usecases/unclaimed_tokens.dart';
import '../../../features/bonus/presentation/cubits/invite_cubit.dart';
import '../module_repo.dart';

class InviteModule implements InjectionModule {
  final GetIt _sl;

  InviteModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => InviteRemoteSource(_sl()));

    _sl.registerLazySingleton(() => ClaimTokenRemoteSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton(() => InviteRepositoryImpl(_sl()));

    _sl.registerLazySingleton(() => ClaimTokenRepoImpl(_sl()));

    /// Use cases
    _sl.registerLazySingleton(() => FetchActiveCode(_sl()));

    _sl.registerLazySingleton(() => FetchClaimGold(_sl()));

    _sl.registerLazySingleton(() => FetchInviteInfo(_sl()));

    _sl.registerLazySingleton(() => FetchRealtimeFunds(_sl()));

    _sl.registerLazySingleton(() => UnclaimedTokens(_sl()));

    _sl.registerLazySingleton(() => ClaimToken(_sl()));

    /// Cubits
    _sl.registerLazySingleton(() => InviteCubit(
          _sl(),
          _sl(),
          _sl(),
          _sl(),
        ));
    // _sl.registerFactory<ClaimTokenCubit>(() => ClaimTokenCubit(
    //       _sl<UnclaimedTokens>(),
    //       _sl<ClaimToken>(),
    //     ));
  }
}
