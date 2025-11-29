import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../features/bonus/presentation/cubits/invite_cubit.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/token_swap_storage.dart';
import '../../utils/storage/secure/token_storage_service.dart';
import '../../utils/storage/secure/user_storage_service.dart';
import '../index.dart';
import '../options/option_cubit.dart';

class UserCubit extends Cubit<UserState> {
  final UserApi _userApi = getIt<UserApi>();
  final TokenStorageService _tokenStorageService;
  UserCubit(this._tokenStorageService)
    : super(const UserState(status: UserStatus.initial()));

  Future<void> init() async {
    await getUserInfo();
  }

  Future<void> getUserInfo({bool forceRefresh = false}) async {
    if (!forceRefresh && state.user != null) {
      return;
    }

    // 如果当前没有用户信息，则设置为加载中状态
    if (!state.status.maybeWhen(success: (_) => true, orElse: () => false)) {
      emit(state.copyWith(status: const UserStatus.loading()));
    }

    try {
      final user = await _userApi.getUserInfo();

      if (user == null) {
        emit(state.copyWith(status: const UserStatus.error('User not found')));
        return;
      }

      emit(
        state.copyWith(
          status: UserStatus.success(user),
          user: user,
          isLoggedIn: true,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(status: UserStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      await Future.wait([
        getIt<UserStorageService>().deleteUser(),
        getIt<TokenStorageService>().deleteTokens(),
        getIt<TokenSwapStorage>().reset(),
      ], eagerError: false);
      getIt<IntelCubit>().reconnectWebSocket();
      getIt<InviteCubit>().reset();
    } catch (e, s) {
      await SentryService().reportError(e, s);
    } finally {
      emit(
        state.copyWith(
          status: const UserStatus.initial(),
          user: null,
          isLoggedIn: false,
        ),
      );
    }
  }

  Future<void> refresh() async {
    await getUserInfo();
  }

  /// 登录成功后的处理流程
  Future<void> loginSuccess() async {
    try {
      emit(
        state.copyWith(isLoggedIn: true, status: const UserStatus.loading()),
      );

      // 1. 获取核心用户信息 (这步通常是必须的，先执行)
      await getUserInfo(forceRefresh: true);

      // 如果 getUserInfo 失败了（例如网络断了），是否还继续？通常需要判断状态。
      if (state.user == null) return;

      // 2. 并行初始化其他模块 (优化：最大化并发)
      // 使用 Future.wait 让所有不相互依赖的初始化并行跑
      await Future.wait([
        // WebSocket
        getIt<IntelCubit>().connectWebSocket(),

        // 其他 Cubit 初始化 (假设它们只依赖 Token 或 UserID)
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
      await SentryService().reportError(e, s);
    }
  }
}
