import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/token_detail/security/security_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
class TokenDetailState with _$TokenDetailState {
  const factory TokenDetailState({
    @Default(null) Token? token,
    @Default(null) TokenDetailSecurity? securitys,
    @Default(null) TokenDetailInfo? tokenDetailInfo,
    @Default(1) int tokenAssociatedIntelsPage,
    @Default(10) int tokenAssociatedIntelsPageSize,
    @Default(false) bool isNotMore,
    @Default(TokenAssociatedIntelsState.initial())
    TokenAssociatedIntelsState tokenAssociatedIntelsState,
    @Default([]) List<Intel>? tokenAssociatedIntels,
    @Default(TokenDetailSecurityState.initial())
    TokenDetailSecurityState tokenDetailSecurityState,
    @Default(TokenDetailIntelState.initial())
    TokenDetailIntelState tokenDetailIntelState,
    @Default(TokenDetailInfoState.initial())
    TokenDetailInfoState tokenDetailInfoState,
  }) = _TokenDetailState;
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
