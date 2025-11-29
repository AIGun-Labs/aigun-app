import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'currency_state.freezed.dart';

@freezed
sealed class CurrencyState with _$CurrencyState {
  const factory CurrencyState({
    @Default(CommonCurrencies) Currency selectedCurrency,
    @Default({}) Map<String, double> exchangeRates,
    @Default(false) bool isLoading,
    String? error,
  }) = _CurrencyState;
}
