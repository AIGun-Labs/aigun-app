import 'package:get_it/get_it.dart';

import '../../../data/services/http/dio_client.dart';
import '../../../features/bonus/data/repositories/claim_token_repo_impl.dart';
import '../../../features/bonus/data/repositories/invite_repo_impl.dart';
import '../../../features/bonus/data/sources/claim_token_remote_source.dart';
import '../../../features/bonus/data/sources/invite_remote_source.dart';
import '../../../features/bonus/domain/repositories/claim_token_repo.dart';
import '../../../features/bonus/domain/repositories/invite_repo.dart';
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
    _sl.registerLazySingleton<InviteRemoteSource>(
        () => InviteRemoteSource(_sl<DioClient>()));
    _sl.registerLazySingleton<ClaimTokenRemoteSource>(
        () => ClaimTokenRemoteSource(_sl<DioClient>()));

    /// Repositories
    _sl.registerLazySingleton<InviteRepository>(
        () => InviteRepositoryImpl(_sl<InviteRemoteSource>()));
    _sl.registerLazySingleton<ClaimTokenRepo>(
        () => ClaimTokenRepoImpl(_sl<ClaimTokenRemoteSource>()));

    /// Use cases
    _sl.registerLazySingleton<FetchActiveCode>(
        () => FetchActiveCode(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchClaimGold>(
        () => FetchClaimGold(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchInviteInfo>(
        () => FetchInviteInfo(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchRealtimeFunds>(
        () => FetchRealtimeFunds(_sl<InviteRepository>()));
    _sl.registerLazySingleton<UnclaimedTokens>(
        () => UnclaimedTokens(_sl<ClaimTokenRepo>()));
    _sl.registerLazySingleton<ClaimToken>(
        () => ClaimToken(_sl<ClaimTokenRepo>()));

    /// Cubits
    _sl.registerLazySingleton<InviteCubit>(() => InviteCubit(
          _sl<FetchRealtimeFunds>(),
          _sl<FetchInviteInfo>(),
          _sl<FetchActiveCode>(),
          _sl<FetchClaimGold>(),
        ));
    // _sl.registerFactory<ClaimTokenCubit>(() => ClaimTokenCubit(
    //       _sl<UnclaimedTokens>(),
    //       _sl<ClaimToken>(),
    //     ));
  }
}
