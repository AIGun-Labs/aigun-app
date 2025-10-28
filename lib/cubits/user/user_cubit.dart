import 'dart:async';

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
      await Future.wait([
        // 清除用户数据
        UserStorageService().deleteUser().catchError((e) {
          Logger.error("deleteUser error: $e");
          return null;
        }),
        // 清除令牌
        TokenStorageService().deleteTokens().catchError((e) {
          Logger.error("deleteTokens error: $e");
          return null;
        }),
        getUserSubscriptions().catchError((e) {
          Logger.error("getUserSubscriptions error: $e");
          return null;
        }),
      ]);
      getIt<IntelCubit>().reconnectWebSocket();
      // 重置状态为初始状态
      emit(state.copyWith(status: const UserStatus.initial()));
    } catch (e, s) {
      // 即使清除失败，也要重置状态
      emit(state.copyWith(status: const UserStatus.initial()));
      await SentryService().reportError(e, s);
    }
  }

  Future<void> getUserSubscriptions() async {
    try {
      final subscriptions = await _userApi.getUserSubscriptions();

      await getIt<UserStorageService>().saveUserSubscriptions(subscriptions);
      emit(state.copyWith(subscriptions: subscriptions));
    } catch (e, s) {
      emit(state.copyWith(status: UserStatus.error(e.toString())));
      await SentryService().reportError(e, s);
    }
  }
}
