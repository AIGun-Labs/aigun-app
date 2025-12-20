part of 'new_user_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
class NewUserState with _$NewUserState {
  NewUserState({
    this.authStatus = AuthStatus.unknown,
    this.userInfo,
    this.tokens,
  });

  @override
  final AuthStatus authStatus;

  @override
  final AuthUserEntity? userInfo;

  @override
  final ({String? access, String? refresh})? tokens;

  bool get isAuthenticated => authStatus == AuthStatus.authenticated;
}
