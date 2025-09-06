import 'package:flutter_aigun/config/chain.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_setting_state.freezed.dart';
part 'trade_setting_state.g.dart';

final defaultSettings = {
  ChainConfig.chainIdMap['solana']!: TradeCustomSetting(
    slippage: 2,
    mevProtect: true,
    priorityFee: "0",
    tipFee: "0",
  ),
  ChainConfig.chainIdMap['eth']!: TradeCustomSetting(
    slippage: 2,
    mevProtect: true,
    gasPrice: "5",
  ),
  ChainConfig.chainIdMap['bsc']!: TradeCustomSetting(
    slippage: 2,
    gasPrice: "5",
  ),
  ChainConfig.chainIdMap['base']!: TradeCustomSetting(
    slippage: 2,
    gasPrice: "5",
  ),
};

@freezed
class TradeSettingState with _$TradeSettingState {
  @JsonSerializable()
  const factory TradeSettingState({
    @Default(TradeMode.fast) TradeMode mode,
    required Map<int, TradeCustomSetting> customSettings,
  }) = _TradeSettingState;

  factory TradeSettingState.initial() {
    return TradeSettingState(
        mode: TradeMode.fast, customSettings: defaultSettings);
  }

  factory TradeSettingState.fromJson(Map<String, dynamic> json) =>
      _$TradeSettingStateFromJson(json);
}
