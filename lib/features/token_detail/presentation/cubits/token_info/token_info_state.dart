part of 'token_info_cubit.dart';

enum TokenInfoStatus { initial, loading, success, error }

@freezed
class TokenInfoState with _$TokenInfoState {
  @override
  final TokenInfoStatus status;
  @override
  final TokenInfoEntity? tokenInfo;
  @override
  final String errorMessage;

  const TokenInfoState({
    this.status = TokenInfoStatus.initial,
    this.tokenInfo,
    this.errorMessage = '',
  });
}
