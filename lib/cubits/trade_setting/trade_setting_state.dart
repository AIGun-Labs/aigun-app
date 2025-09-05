import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trade_setting_state.freezed.dart';
part 'trade_setting_state.g.dart';

@freezed
class TradeSettingState with _$TradeSettingState {
  @JsonSerializable()
  const factory TradeSettingState({
    @Default(TradeMode.lightning) TradeMode mode,
    required Map<String, TradeCustomSetting> customSettings,
  }) = _TradeSettingState;

  factory TradeSettingState.initial() {
    return const TradeSettingState(mode: TradeMode.lightning, customSettings: {
      "solana": TradeCustomSetting(
          slippage: "2",
          mevProtect: true,
          priorityFee: "0.002",
          tipFee: "0.001"),
      "ethereum": TradeCustomSetting(
        slippage: "2",
        mevProtect: true,
        gasPrice: "5",
      ),
      "bnb": TradeCustomSetting(
        slippage: "2",
        mevProtect: true,
        gasPrice: "5",
      ),
      "base": TradeCustomSetting(
        slippage: "2",
        gasPrice: "5",
      )
    });
  }

  factory TradeSettingState.fromJson(Map<String, dynamic> json) =>
      _$TradeSettingStateFromJson(json);
}
