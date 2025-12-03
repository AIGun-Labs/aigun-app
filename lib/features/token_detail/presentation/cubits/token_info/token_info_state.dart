part of 'token_info_cubit.dart';

@freezed
class TokenInfoState with _$TokenInfoState {
  const factory TokenInfoState.initial() = _Initial;
  const factory TokenInfoState.loading() = _Loading;
  const factory TokenInfoState.success(TokenInfoEntity token) = _Success;
  const factory TokenInfoState.error(String message) = _Error;
}
