import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../enums/trade_mode.dart';

part 'trade_custom_setting.freezed.dart';
part 'trade_custom_setting.g.dart';

int _slippageFromJson(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

@freezed
sealed class TradeCustomSetting with _$TradeCustomSetting {
  const factory TradeCustomSetting({
    @JsonKey(name: 'mode') TradeMode? mode,
    @Default(0)
    @JsonKey(name: 'slippage', fromJson: _slippageFromJson)
    int slippage, //
    @Default(false) @JsonKey(name: 'mev_protect') bool mevProtect, // MEV()
    @Default('')
    @JsonKey(name: 'priority_fee')
    String? priorityFee, // for solana
    @Default('') @JsonKey(name: 'tip_fee') String? tipFee, // for solana
    @Default('') @JsonKey(name: 'gas_price') String? gasPrice, // for evm
  }) = _TradeCustomSetting;

  factory TradeCustomSetting.fromJson(Map<String, dynamic> json) =>
      _$TradeCustomSettingFromJson(json);
}
