import 'package:freezed_annotation/freezed_annotation.dart';

import '../../trade/setting/trade_custom_setting.dart';

part 'trade_config.freezed.dart';
part 'trade_config.g.dart';

@freezed
sealed class TradeConfig with _$TradeConfig {
  const factory TradeConfig({
    @JsonKey(name: 'network') required String network,
    @JsonKey(name: 'mode') required String mode,
    @JsonKey(name: 'config') required TradeCustomSetting config,
  }) = _TradeConfig;

  factory TradeConfig.fromJson(Map<String, dynamic> json) =>
      _$TradeConfigFromJson(json);
}
