import 'dart:async';

import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';

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

    final token = await _tokenStorageService.getAccessToken();

    // 如果token不存在，则设置为初始状态
    if (token == null) {
      emit(state.copyWith(status: const UserStatus.initial()));
      return;
    }

    try {
      // 获取用户信息
      final user = await _userApi.getUserInfo();

      // 获取用户信息成功后，设置为成功状态
      emit(state.copyWith(status: UserStatus.success(user)));
    } catch (e) {
      // 获取用户信息失败后，设置为错误状态
      emit(state.copyWith(status: UserStatus.error(e.toString())));
    }
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      // 清除用户数据
      await UserStorageService().deleteUser();
      // 清除令牌
      await TokenStorageService().deleteTokens();

      // 重置状态为初始状态
      emit(state.copyWith(status: const UserStatus.initial()));
    } catch (e) {
      // 即使清除失败，也要重置状态
      emit(state.copyWith(status: const UserStatus.initial()));
    }
  }

  Future<void> getUserSubscriptions() async {
    try {
      final subscriptions = await _userApi.getUserSubscriptions();

      getIt<UserStorageService>().saveUserSubscriptions(subscriptions);
      emit(state.copyWith(subscriptions: subscriptions));
    } catch (e) {
      Logger.error("获取用户订阅失败: $e");
      emit(state.copyWith(status: UserStatus.error(e.toString())));
    }
  }
}
