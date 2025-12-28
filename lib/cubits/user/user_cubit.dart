import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../core/service_locator.dart';
import '../../core/services/secure_token_storage_service.dart';
import '../../core/services/secure_user_storage_service.dart';
// import '../../data/services/api/index.dart';
// import '../../data/services/sentry_service.dart';
// import '../../features/auth/presentation/cubits/auth/auth_cubit.dart';
// import '../../utils/logger.dart';
// import '../../utils/storage/local/token_swap_storage.dart';
import '../index.dart';
// import '../options/option_cubit.dart';

@Deprecated(' NewUserCubit ')
class UserCubit extends Cubit<UserState> {
  UserCubit(this._tokenStorageService, this._userStorageService)
    : super(const UserState(status: UserStatus.initial()));
  // ignore: unused_field
  final SecureTokenStorageService _tokenStorageService;
  // ignore: unused_field
  final SecureUserStorageService _userStorageService;
  Future<void> init() async {
    return;
  }

  Future<void> getUserInfo({bool forceRefresh = false}) async {
    return;
  }

  Future<void> logout() async {
    return;
  }

  Future<void> refresh() async {
    return;
  }

  Future<void> loginSuccess() async {
    return;
  }
}
