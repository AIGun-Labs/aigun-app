import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_token_state.freezed.dart';

@freezed
sealed class AddTokenState with _$AddTokenState {
  const factory AddTokenState({
    @Default(false) bool isLoading,
    @Default(false) bool addressError,
    @Default(false) bool chainError,
    @Default('') String tokenAddress,
    // @Default('') String tokenSymbol,
    // @Default('') String tokenName,
    // @Default(0) int decimals,
    // @Default('') String tokenType,
    @Default('1') String chainId,
    @Default(false) bool isSuccess,
    @Default(false) bool isError,
  }) = _AddTokenState;
}
