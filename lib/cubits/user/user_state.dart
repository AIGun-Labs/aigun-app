import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/user/user.dart';

part 'user_state.freezed.dart';

@freezed
class UserStatus with _$UserStatus {
  const factory UserStatus.initial() = _Initial;
  const factory UserStatus.loading() = _Loading;
  const factory UserStatus.success(User user) = _Success;
  const factory UserStatus.error(String message) = _Error;
}

@freezed
sealed class UserState with _$UserState {
  const UserState._();
  const factory UserState({
    @Default(UserStatus.initial()) UserStatus status,
    User? user,
    @Default(false) bool isLoggedIn,
    @Default('') String subscriptions,
  }) = _UserState;

  // bool get isLoggedIn => status.maybeMap(
  //       success: (_) => true,
  //       orElse: () => false,
  //     );

  bool get isLoading => status.maybeMap(
    initial: (_) => true,
    loading: (_) => true,
    orElse: () => false,
  );
}
