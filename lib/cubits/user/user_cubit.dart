import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';

import '../index.dart';

class UserCubit extends Cubit<UserState> {
  final UserApi _userApi = getIt<UserApi>();
  final TokenStorageService _tokenStorageService = getIt<TokenStorageService>();
  UserCubit() : super(const UserState.initial()) {
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    // 获取用户信息时，先设置为加载中状态
    emit(const UserState.loading());

    final token = await _tokenStorageService.getAccessToken();

    if (token == null) {
      return;
    }

    try {
      // 获取用户信息
      final user = await _userApi.getUserInfo();

      // 获取用户信息成功后，设置为成功状态
      emit(UserState.success(user));
    } catch (e) {
      // 获取用户信息失败后，设置为错误状态
      emit(UserState.error(e.toString()));
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
      emit(const UserState.initial());
    } catch (e) {
      // 即使清除失败，也要重置状态
      emit(const UserState.initial());
    }
  }
}
