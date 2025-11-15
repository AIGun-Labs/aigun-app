import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/token_swap_storage.dart';
import '../../utils/storage/secure/token_storage_service.dart';
import '../../utils/storage/secure/user_storage_service.dart';
import '../index.dart';
import '../options/option_cubit.dart';

class UserCubit extends Cubit<UserState> {
  final UserApi _userApi = getIt<UserApi>();
  final TokenStorageService _tokenStorageService = getIt<TokenStorageService>();
  UserCubit() : super(const UserState(status: UserStatus.initial())) {
    init();
  }

  Future<void> init() async {
    getUserInfo();
    getUserSubscriptions();
  }

  Future<void> getUserInfo() async {
    // 获取用户信息时，先设置为加载中状态
    emit(state.copyWith(status: const UserStatus.loading()));

    if (state.isLoggedIn) {
      return;
    }

    final token = await _tokenStorageService.getAccessToken();

    // 如果token不存在，则设置为初始状态
    if (token == null) {
      emit(state.copyWith(status: const UserStatus.initial()));
      return;
    }

    try {
      // 获取用户信息
      final user = await _userApi.getUserInfo();

      if (user == null) {
        emit(state.copyWith(status: const UserStatus.error("Unknown error")));
        return;
      }

      // 获取用户信息成功后，设置为成功状态
      emit(state.copyWith(status: UserStatus.success(user), user: user));
    } catch (e, s) {
      // 获取用户信息失败后，设置为错误状态
      emit(state.copyWith(status: UserStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      await Future.wait([
        UserStorageService().deleteUser(),
        TokenStorageService().deleteTokens(),
        getIt<TokenSwapStorage>().reset()
      ], eagerError: false);
      getIt<IntelCubit>().reconnectWebSocket();
      emit(state.copyWith(status: const UserStatus.initial(), user: null));
    } catch (e, s) {
      emit(state.copyWith(status: const UserStatus.initial(), user: null));
      await SentryService().reportError(e, s);
    }
  }

  Future<void> getUserSubscriptions() async {
    try {
      final token = await _tokenStorageService.getAccessToken();
      if (token == null) {
        emit(state.copyWith(status: const UserStatus.initial()));
        return;
      }

      final subscriptions = await _userApi.getUserSubscriptions();

      await getIt<UserStorageService>().saveUserSubscriptions(subscriptions);
      emit(state.copyWith(subscriptions: subscriptions));
    } catch (e, s) {
      emit(state.copyWith(status: UserStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }

  Future<void> loginSuccess() async {
    try {
      // 2. 并行执行登录操作
      await Future.wait([
        getUserInfo(),
        getIt<IntelCubit>().connectWebSocket(),
      ], eagerError: false);

      // 3. 初始化钱包
      await getIt<WalletCubit>().init().catchError((e) {
        Logger.error("WalletCubit init error: $e");
        return null;
      });

      await getIt<OptionsCubit>().getSingleTypeOptions().catchError((e) {
        Logger.error("OptionsCubit getSingleTypeOptions error: $e");
        return null;
      });

      await getIt<TradeCubit>().init().catchError((e) {
        Logger.error("TradeCubit init error: $e");
        return null;
      });
    } catch (e, s) {
      await SentryService().reportError(e, s);
    }
  }
}
