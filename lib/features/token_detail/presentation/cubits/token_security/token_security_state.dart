part of 'token_security_cubit.dart';

enum TokenSecurityStatus { initial, loading, success, error }

@freezed
class TokenSecurityState with _$TokenSecurityState {
  final TokenSecurityStatus status;
  final TokenSecurityEntity? tokenSecurity;
  final String errorMessage;

  const TokenSecurityState({
    this.status = TokenSecurityStatus.initial,
    this.tokenSecurity,
    this.errorMessage = '',
  });
}
