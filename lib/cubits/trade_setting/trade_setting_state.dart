import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_setting_state.freezed.dart';

enum TradeMode { lightning, gentle }

@freezed
class TradeCustomSetting with _$TradeCustomSetting {
  const factory TradeCustomSetting(
      {@Default("") String? slippage,
      @Default("") String? gasPrice,
      @Default("") String? gasLimit,
      @Default("") String? BriberyFee}) = _TradeCustomSetting;
}

@freezed
class TradeSettingState with _$TradeSettingState {
  const factory TradeSettingState({
    @Default(TradeMode.lightning) TradeMode tradeMode,
    @Default(TradeCustomSetting()) TradeCustomSetting solana,
    @Default(TradeCustomSetting()) TradeCustomSetting ethereum,
    @Default(TradeCustomSetting()) TradeCustomSetting bnb,
  }) = _TradeSettingState;
}
