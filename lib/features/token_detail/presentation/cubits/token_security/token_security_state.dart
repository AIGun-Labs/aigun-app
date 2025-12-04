part of 'token_security_cubit.dart';

enum TokenSecurityStatus { initial, loading, success, error }

@freezed
class TokenSecurityState with _$TokenSecurityState {
  @override
  final TokenSecurityStatus status;
  @override
  final TokenSecurityEntity? tokenSecurity;
  @override
  final String errorMessage;

  const TokenSecurityState({
    this.status = TokenSecurityStatus.initial,
    this.tokenSecurity,
    this.errorMessage = '',
  });
}
