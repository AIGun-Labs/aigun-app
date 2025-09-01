import 'package:flutter_aigun/data/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const UserState._();

  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.success(User user) = _Success;
  const factory UserState.error(String message) = _Error;

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
