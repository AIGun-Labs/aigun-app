import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';
import '../../data/models/intel/intel.dart';
import '../../data/models/user/profit/profit.dart';
import '../../enums/token_security_type.dart';
import '../../utils/extensions/string.dart';
import '../../widgets/token/models/token.dart';

part 'token_detail_state.freezed.dart';

@freezed
class TokenDetailSecurityState with _$TokenDetailSecurityState {
  const factory TokenDetailSecurityState.initial() =
      _TokenDetailSecurityInitial;
  const factory TokenDetailSecurityState.loading() =
      _TokenDetailSecurityLoading;
  const factory TokenDetailSecurityState.success(
      TokenDetailSecurity tokenDetailSecurity) = _TokenDetailSecuritySuccess;
  const factory TokenDetailSecurityState.error(String message) =
      _TokenDetailSecurityError;
}

@freezed
class TokenDetailIntelState with _$TokenDetailIntelState {
  const factory TokenDetailIntelState.initial() = _TokenDetailIntelInitial;
  const factory TokenDetailIntelState.loading() = _TokenDetailIntelLoading;
  const factory TokenDetailIntelState.success(Intel intel) =
      _TokenDetailIntelSuccess;
  const factory TokenDetailIntelState.error(String message) =
      _TokenDetailIntelError;
}

@freezed
class TokenDetailUrlsState with _$TokenDetailUrlsState {
  const factory TokenDetailUrlsState.initial() = _TokenDetailUrlsInitial;
  const factory TokenDetailUrlsState.loading() = _TokenDetailUrlsLoading;
  const factory TokenDetailUrlsState.success(TokenDetailUrls tokenDetailUrls) =
      _TokenDetailUrlsSuccess;
  const factory TokenDetailUrlsState.error() = _TokenDetailUrlsError;
}

@freezed
class TokenHoldingsState with _$TokenHoldingsState {
  const factory TokenHoldingsState.initial() = _TokenHoldingsInitial;
  const factory TokenHoldingsState.loading() = _TokenHoldingsLoading;
  const factory TokenHoldingsState.success(List<dynamic> tokenHoldings) =
      _TokenHoldingsSuccess;
  const factory TokenHoldingsState.error(String message) = _TokenHoldingsError;
}

@freezed
class TokenIntelCountState with _$TokenIntelCountState {
  const factory TokenIntelCountState.initial() = _TokenIntelCountInitial;
  const factory TokenIntelCountState.loading() = _TokenIntelCountLoading;
  const factory TokenIntelCountState.success(int tokenIntelCount) =
      _TokenIntelCountSuccess;
  const factory TokenIntelCountState.error(String message) =
      _TokenIntelCountError;
}

@freezed
class TokenProfitState with _$TokenProfitState {
  const factory TokenProfitState.initial() = _TokenProfitInitial;
  const factory TokenProfitState.loading() = _TokenProfitLoading;
  const factory TokenProfitState.success(UserProfit tokenProfit) =
      _TokenProfitSuccess;
  const factory TokenProfitState.error(String message) = _TokenProfitError;
}

@freezed
class TokenDetailState with _$TokenDetailState {
  const TokenDetailState._();
  const factory TokenDetailState({
    @Default(null) Token? token,
    @Default(null) TokenDetailSecurity? securitys,
    @Default(null) TokenDetailInfo? tokenDetailInfo,
    @Default(1) int tokenAssociatedIntelsPage,
    @Default(10) int tokenAssociatedIntelsPageSize,
    @Default([]) List<dynamic>? tokenHoldings,
    @Default(false) bool isNotMore,
    @Default(null) TokenDetailUrls? tokenUrls,
    @Default(0) int tokenRiskCount,
    @Default(0) int tokenIntelCount,
    @Default(null) UserProfit? tokenProfit,
    @Default(TokenAssociatedIntelsState.initial())
    TokenAssociatedIntelsState tokenAssociatedIntelsState,
    @Default([]) List<Intel>? tokenAssociatedIntels,
    @Default(TokenDetailSecurityState.initial())
    TokenDetailSecurityState tokenDetailSecurityState,
    @Default(TokenDetailIntelState.initial())
    TokenDetailIntelState tokenDetailIntelState,
    @Default(TokenDetailInfoState.initial())
    TokenDetailInfoState tokenDetailInfoState,
    @Default(TokenDetailUrlsState.initial())
    TokenDetailUrlsState tokenDetailUrlsState,
    @Default(TokenHoldingsState.initial())
    TokenHoldingsState tokenHoldingsState,
    @Default(TokenIntelCountState.initial())
    TokenIntelCountState tokenIntelCountState,
    @Default(TokenProfitState.initial()) TokenProfitState tokenProfitState,
    @Default(null) String? tokenType,
  }) = _TokenDetailState;

  static const TokenDetailState initial = TokenDetailState();

  bool get tokenAssociatedIntelsIsEmpty =>
      tokenAssociatedIntels?.isEmpty ?? true;

  bool get tokenAssociatedIntelsIsError => tokenAssociatedIntelsState.maybeWhen(
      orElse: () => false, error: (error) => true);

  double get tokenProfitValue => tokenProfit?.value.toDouble() ?? 0.0;
  double get tokenProfitProfit => tokenProfit?.profit.toDouble() ?? 0.0;
  double get tokenProfitHoldings => tokenProfit?.balance.toDouble() ?? 0.0;
  double get tokenProfitProfitPercent =>
      tokenProfit?.riseFall.toDouble() ?? 0.0;
}

@freezed
class TokenDetailInfoState with _$TokenDetailInfoState {
  const factory TokenDetailInfoState.initial() = _TokenDetailInfoInitial;
  const factory TokenDetailInfoState.loading() = _TokenDetailInfoLoading;
  const factory TokenDetailInfoState.success(TokenDetailInfo tokenDetailInfo) =
      _TokenDetailInfoSuccess;
  const factory TokenDetailInfoState.error(String message) =
      _TokenDetailInfoError;
}

@freezed
class TokenAssociatedIntelsState with _$TokenAssociatedIntelsState {
  const factory TokenAssociatedIntelsState.initial() =
      _TokenAssociatedIntelsInitial;
  const factory TokenAssociatedIntelsState.loading() =
      _TokenAssociatedIntelsLoading;
  const factory TokenAssociatedIntelsState.success(
      List<Intel> tokenAssociatedIntels) = _TokenAssociatedIntelsSuccess;
  const factory TokenAssociatedIntelsState.error(String message) =
      _TokenAssociatedIntelsError;
}

extension TokenDetailStateX on TokenDetailState {
  num get riskAmount =>
      securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.risk.type)
          .length ??
      0;

  num get warningAmount =>
      securitys?.contractAnaly
          .where((element) =>
              element.isSafe == false &&
              element.type == TokenSecurityType.attention.type)
          .length ??
      0;

  int get allNotSafeCount =>
      securitys?.contractAnaly
          .where((element) => element.isSafe == false)
          .length ??
      0;
}
