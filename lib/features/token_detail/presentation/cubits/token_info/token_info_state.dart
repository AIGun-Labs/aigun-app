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

  @override
  final String address;
  @override
  final String network;

  @override
  final String? tokenType;

  @override
  final UrlsEntity? urls;

  const TokenInfoState({
    this.status = TokenInfoStatus.initial,
    this.address = '',
    this.network = '',
    this.tokenType,
    this.tokenInfo,
    this.urls,
    this.errorMessage = '',
  });
}
