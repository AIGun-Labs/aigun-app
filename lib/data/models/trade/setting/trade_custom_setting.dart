import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_custom_setting.freezed.dart';
part 'trade_custom_setting.g.dart';

@freezed
class TradeCustomSetting with _$TradeCustomSetting {
  const factory TradeCustomSetting({
    @Default('2') String slippage, // 滑点
    @Default(false) bool mevProtect, // 是否启用MEV保护(防夹功能)
    @Default('') String? priorityFee, // for solana
    @Default('') String? tipFee, // for solana
    @Default('') String? gasPrice, // for evm
  }) = _TradeCustomSetting;

  factory TradeCustomSetting.fromJson(Map<String, dynamic> json) =>
      _$TradeCustomSettingFromJson(json);
}
