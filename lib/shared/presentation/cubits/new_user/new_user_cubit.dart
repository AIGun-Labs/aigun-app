import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/services/secure_token_storage_service.dart';
import '../../../../core/services/secure_user_storage_service.dart';
import '../../../../cubits/intel/intel_cubit.dart';
import '../../../../cubits/options/option_cubit.dart';
import '../../../../cubits/trade/trade_cubit.dart';
import '../../../../cubits/wallet_backups/wallet_cubit.dart';
import '../../../../data/services/sentry_service.dart';
import '../../../../features/auth/application/usecases/get_user_info.dart';
import '../../../../features/auth/domain/entities/auth_result_entity.dart';
import '../../../../features/auth/domain/entities/auth_user_entity.dart';
import '../../../../features/auth/infrastructure/mappers/auth_mapper.dart';
import '../../../../features/auth/presentation/cubits/auth/auth_cubit.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/storage/local/token_swap_storage.dart';

part 'new_user_cubit.freezed.dart';
part 'new_user_state.dart';

class NewUserCubit extends Cubit<NewUserState> {
  NewUserCubit(this._tokenStorageService, this._userStorageService)
    : super(NewUserState());
  final SecureTokenStorageService _tokenStorageService;
  final SecureUserStorageService _userStorageService;

  Future<void> init() async {
    final tokens = await _tokenStorageService.readTokens();

    if (tokens.access == null) {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
      return;
    }
    emit(state.copyWith(authStatus: AuthStatus.authenticated, tokens: tokens));

    final userInfo = await _userStorageService.readUserInfo();

    emit(state.copyWith(userInfo: userInfo.toEntity()));
  }

  Future<void> saveTokens({String? access, String? refresh}) async {
    await _tokenStorageService.writeTokens(
      accessToken: access,
      refreshToken: refresh,
    );
    emit(
      state.copyWith(
        authStatus: AuthStatus.authenticated,
        tokens: (
          access: access ?? state.tokens?.access,
          refresh: refresh ?? state.tokens?.refresh,
        ),
      ),
    );
  }

  Future<void> deleteTokens() async {
    await _tokenStorageService.clearTokens();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated, tokens: null));
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        _userStorageService.clearUserInfo(),
        _tokenStorageService.clearTokens(),
        getIt<TokenSwapStorage>().reset(),
      ], eagerError: false);
      getIt<IntelCubit>().reconnectWebSocket();
      getIt<AuthCubit>().reset();
    } catch (e, s) {
      await SentryService().reportError(e, s);
    } finally {
      emit(
        state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          userInfo: null,
          tokens: null,
        ),
      );
    }
  }

  Future<void> saveUserInfo(AuthUserEntity userInfo) async {
    await _userStorageService.writeUserInfo(userInfo.toModel());
    emit(state.copyWith(userInfo: userInfo));
  }

  Future<void> updateUserInfo() async {
    final result = await getIt<GetUserInfo>().call();
    if (result.isSuccess) {
      emit(state.copyWith(userInfo: result.value!));
    }
  }

  Future<void> login(AuthResultEntity authResult) async {
    try {
      if (authResult is AuthResultExistingUser ||
          authResult is AuthResultRegistered) {
        await saveTokens(
          access: authResult.tokens?.accessToken,
          refresh: authResult.tokens?.refreshToken,
        );
        await saveUserInfo(authResult.user!);
      }
      await Future.wait([
        // WebSocket
        getIt<IntelCubit>().connectWebSocket(),
        getIt<WalletCubit>().init().catchError(
          (e) => Logger.error('Wallet init error: $e'),
        ),
        getIt<OptionsCubit>().getSingleTypeOptions().catchError(
          (e) => Logger.error('Options init error: $e'),
        ),
        getIt<TradeCubit>().init().catchError(
          (e) => Logger.error('Trade init error: $e'),
        ),
      ], eagerError: false);
    } catch (e, s) {
      // emit(state.copyWith(status: UserStatus.error(e.toString())));
      await getIt<SentryService>().reportError(e, s);
    }
  }
}
