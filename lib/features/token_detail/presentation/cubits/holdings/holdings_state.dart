part of 'holdings_cubit.dart';

enum HoldingsStatus { initial, loading, success, error }

@freezed
class HoldingsState with _$HoldingsState {
  @override
  final HoldingsStatus status;
  @override
  final TokenProfitEntity? tokenProfit;
  @override
  final String errorMessage;

  const HoldingsState({
    this.status = HoldingsStatus.initial,
    this.tokenProfit,
    this.errorMessage = '',
  });
}
