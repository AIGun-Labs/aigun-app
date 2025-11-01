import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/features/bonus/data/repositories/invite_repository_impl.dart';
import 'package:flutter_aigun/features/bonus/data/sources/invite_remote_source.dart';
import 'package:flutter_aigun/features/bonus/domain/repositories/invite_repository.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_active_code.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_claim_gold.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_invite_info.dart';
import 'package:flutter_aigun/features/bonus/domain/usecases/fetch_realtime_funds.dart';
import 'package:flutter_aigun/features/bonus/presentation/cubits/invite_cubit.dart';
import 'package:get_it/get_it.dart';

import '../module_repo.dart';

class InviteModule implements InjectionModule {
  final GetIt _sl;

  InviteModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton<InviteRemoteSource>(
        () => InviteRemoteSource(_sl<DioClient>()));

    /// Repositories
    _sl.registerLazySingleton<InviteRepository>(
        () => InviteRepositoryImpl(_sl<InviteRemoteSource>()));

    /// Use cases
    _sl.registerLazySingleton<FetchActiveCode>(
        () => FetchActiveCode(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchClaimGold>(
        () => FetchClaimGold(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchInviteInfo>(
        () => FetchInviteInfo(_sl<InviteRepository>()));
    _sl.registerLazySingleton<FetchRealtimeFunds>(
        () => FetchRealtimeFunds(_sl<InviteRepository>()));

    /// Cubits
    _sl.registerLazySingleton<InviteCubit>(() => InviteCubit(
          _sl<FetchRealtimeFunds>(),
          _sl<FetchInviteInfo>(),
          _sl<FetchActiveCode>(),
          _sl<FetchClaimGold>(),
        ));
  }
}
