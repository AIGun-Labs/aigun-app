import 'package:flutter_aigun/data/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserStatus with _$UserStatus {
  const UserStatus._();

  const factory UserStatus.initial() = _Initial;
  const factory UserStatus.loading() = _Loading;
  const factory UserStatus.success(User user) = _Success;
  const factory UserStatus.error(String message) = _Error;

  bool get isLoggedIn => maybeMap(
        success: (_) => true,
        orElse: () => false,
      );

  bool get isLoading => maybeMap(
        initial: (_) => true,
        loading: (_) => true,
        orElse: () => false,
      );
}

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(UserStatus.initial()) UserStatus status,
    @Default([]) List<String> subscriptions,
  }) = _UserState;
}
