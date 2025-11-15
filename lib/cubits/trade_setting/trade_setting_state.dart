import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/trade/setting/trade_custom_setting.dart';
import "../../data/models/user/index.dart";
import '../../enums/trade_mode.dart';

part 'trade_setting_state.freezed.dart';
part 'trade_setting_state.g.dart';

final defaultSettings = {
  "solana": const TradeCustomSetting(
    mode: TradeMode.fast,
    slippage: 2,
    mevProtect: true,
    priorityFee: "0",
    tipFee: "0",
  ),
  "eth": const TradeCustomSetting(
    mode: TradeMode.fast,
    slippage: 2,
    mevProtect: true,
    gasPrice: "5",
  ),
  "bsc": const TradeCustomSetting(
    mode: TradeMode.fast,
    slippage: 2,
    mevProtect: true,
    gasPrice: "5",
  ),
  "base": const TradeCustomSetting(
    mode: TradeMode.fast,
    slippage: 2,
    mevProtect: true,
    gasPrice: "5",
  ),
};

@freezed
class GetTradeSettingStatus with _$GetTradeSettingStatus {
  const factory GetTradeSettingStatus.initial() = _GetTradeSettingInitial;
  const factory GetTradeSettingStatus.loading() = _GetTradeSettingLoading;
  const factory GetTradeSettingStatus.success(TradeConfig tradeConfig) =
      _GetTradeSettingSuccess;
  const factory GetTradeSettingStatus.error(String message) =
      _GetTradeSettingError;
}

@freezed
class TradeSettingStatus with _$TradeSettingStatus {
  const factory TradeSettingStatus.initial() = _TradeSettingInitial;
  const factory TradeSettingStatus.loading() = _TradeSettingLoading;
  const factory TradeSettingStatus.success() = _TradeSettingSuccess;
  const factory TradeSettingStatus.error() = _TradeSettingError;
}

@freezed
class TradeLiveDataStatus with _$TradeLiveDataStatus {
  const factory TradeLiveDataStatus.initial() = _TradeLiveDataInitial;
  const factory TradeLiveDataStatus.loading() = _TradeLiveDataLoading;
  const factory TradeLiveDataStatus.success(TradeLiveData liveData) =
      _TradeLiveDataSuccess;
  const factory TradeLiveDataStatus.error(String message) = _TradeLiveDataError;
}

@freezed
class TradeSettingState with _$TradeSettingState {
  TradeSettingState._();
  @JsonSerializable()
  factory TradeSettingState({
    @Default("solana") String network,
    @Default({}) Map<String, TradeCustomSetting> customSettings,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(GetTradeSettingStatus.initial())
    GetTradeSettingStatus getTradeSettingStatus,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TradeSettingStatus.initial())
    TradeSettingStatus tradeSettingStatus,
    @Default(TradeLiveData()) TradeLiveData liveData,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TradeLiveDataStatus.initial())
    TradeLiveDataStatus liveDataStatus,
  }) = _TradeSettingState;

  factory TradeSettingState.initial() {
    return TradeSettingState(
        customSettings: defaultSettings,
        getTradeSettingStatus: const GetTradeSettingStatus.initial(),
        tradeSettingStatus: const TradeSettingStatus.initial());
  }

  TradeMode get mode => customSettings[network]?.mode ?? TradeMode.fast;

  TradeCustomSetting get setting =>
      customSettings[network] ?? const TradeCustomSetting();

  bool get mev {
    if (mode.value == TradeMode.custom.value) {
      return setting.mevProtect;
    }

    return true;
  }

  factory TradeSettingState.fromJson(Map<String, dynamic> json) =>
      _$TradeSettingStateFromJson(json);
}
