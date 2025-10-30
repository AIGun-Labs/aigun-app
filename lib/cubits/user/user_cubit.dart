import 'dart:async';

import 'package:flutter_aigun/config/subscriptions.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';

import '../../core/service_locator.dart';
import '../index.dart';

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
      emit(state.copyWith(status: UserStatus.success(user)));
    } catch (e, s) {
      // 获取用户信息失败后，设置为错误状态
      emit(state.copyWith(status: UserStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      // 做一些清理操作
      getIt<IntelCubit>().reset();

// 清理用户数据
      await Future.wait([
        UserStorageService().deleteUser(),
        UserStorageService().saveUserSubscriptions(SUBSCRIPTIONS_EVENT_HANDLER),
        TokenStorageService().deleteTokens()
      ], eagerError: false);
      getIt<IntelCubit>().reconnectWebSocket();
      // 重置状态为初始状态
      emit(state.copyWith(status: const UserStatus.initial()));
      // 获取登录用户的情报（从第1页开始）
      await getIt<IntelCubit>().getIntelsHistory();
    } catch (e, s) {
      // 即使清除失败，也要重置状态
      emit(state.copyWith(status: const UserStatus.initial()));
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
      // 1. 重置情报状态，清除未登录状态的情报
      getIt<IntelCubit>().reset();

      // 2. 并行执行登录操作
      await Future.wait([
        getUserInfo(),
        getUserSubscriptions(),
        getIt<IntelCubit>().connectWebSocket()
      ], eagerError: false);

      // 3. 初始化钱包
      await getIt<WalletCubit>().init().catchError((e) {
        Logger.error("WalletCubit init error: $e");
        return null;
      });

      // 4. 获取登录用户的情报（从第1页开始）
      await getIt<IntelCubit>()
          .getIntelsHistory(forceRefresh: true)
          .catchError((e) {
        Logger.error("getIntelsHistory error: $e");
        return null;
      });
    } catch (e, s) {
      await SentryService().reportError(e, s);
    }
  }
}
