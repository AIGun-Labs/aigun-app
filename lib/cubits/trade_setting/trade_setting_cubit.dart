import 'dart:async';

import 'package:flutter_aigun/core/polling/polling_service.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_aigun/core/constant/count.dart';

class TradeSettingCubit extends Cubit<TradeSettingState> {
  final TradeSettingStorage _storage;
  PollingService? _pollingService;

  // 使用 getter 延迟获取 TradeCubit，避免循环依赖
  TradeCubit get tradeCubit => getIt<TradeCubit>();
  Timer? _timer;
  TradeSettingCubit(this._storage) : super(TradeSettingState.initial()) {
    init();

    startPollingLiveData();
  }

  void startPollingLiveData() {
    _pollingService?.stop();

    _pollingService = PollingService(
        baseInterval: const Duration(seconds: TWENTY),
        fetcher: (cancel) async {
          emit(state.copyWith(
              liveDataStatus: const TradeLiveDataStatus.loading()));
          return await getTradeLiveData();
        },
        onError: (error, stack) {
          emit(state.copyWith(
              liveDataStatus: const TradeLiveDataStatus.error("error")));
        },
        onData: (liveData) {
          emit(state.copyWith(
              liveData: liveData,
              liveDataStatus: TradeLiveDataStatus.success(liveData)));
        });

    _pollingService?.start();
  }

  void stopPollingBalance() {
    _pollingService?.stop();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<TradeLiveData?> getTradeLiveData() async {
    return getIt<UserApi>()
        .getTradeLiveData(tradeCubit.state.fromToken?.chainId ?? "");
  }

  Future<void> init() async {
    await getUserTradeConfig();
    await getTradeLiveData();
    // await _loadSettings();
  }

  Future<void> updateNetwork(String network) async {
    emit(state.copyWith(network: network.toLowerCase()));

    final newCustomSetting = getTradeCustomSettingByNetwork(network);

    updateCustomSetting(newCustomSetting);
  }

  Future<void> _saveSettings(TradeSettingState tradeSettingState) async {
    try {
      await _storage.saveTradeSetting(tradeSettingState.toJson());

      emit(state);
    } catch (e, s) {
      emit(
          state.copyWith(tradeSettingStatus: const TradeSettingStatus.error()));

      await SentryService()
          .reportError(e, s, tags: {"feature": "_saveSettings"});
    }
  }

// update trade mode
  void updateTradeMode(TradeMode mode) {
    final currentCustom = state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mode: mode);
    updateCustomSetting(newCustom);
  }

// update custom setting
  void updateCustomSetting(TradeCustomSetting setting) {
    final newCustomSettings =
        Map<String, TradeCustomSetting>.from(state.customSettings);
    newCustomSettings[state.network.toLowerCase()] = setting;

    emit(state.copyWith(customSettings: newCustomSettings));
  }

  /// 为指定网络更新自定义设置
  void updateCustomSettingForNetwork(
      String networkKey, TradeCustomSetting setting) {
    // 确保初始化了所有网络的默认设置
    final newCustomSettings = Map<String, TradeCustomSetting>.from(
        state.customSettings.isEmpty ? defaultSettings : state.customSettings);

    newCustomSettings[networkKey.toLowerCase()] = setting;

    emit(state.copyWith(customSettings: newCustomSettings));
  }

  TradeCustomSetting getTradeCustomSettingByNetwork(String network) {
    return state.customSettings[network.toLowerCase()] ??
        const TradeCustomSetting();
  }

// update slippage
  void updateSlippage(int slippage) {
    final newCustom = state.customSettings[state.network.toLowerCase()]
        ?.copyWith(slippage: slippage);

    if (newCustom != null) {
      updateCustomSetting(newCustom);
      // 操作 slippage 时，更新 mode 为 custom
      updateTradeMode(TradeMode.custom);
    }
  }

// update mev protect
  void updateMevProtect(bool mevProtect) {
    final currentCustom = state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mevProtect: mevProtect);
    updateCustomSetting(newCustom);
    // 操作 mev protect 时，更新 mode 为 custom
    updateTradeMode(TradeMode.custom);
  }

  bool getMevProtect() {
    return state.customSettings[state.network.toLowerCase()]?.mevProtect ??
        false;
  }

  void resetAll() {
    // _saveSettings(TradeSettingState.initial());
    // emit(state.copyWith(mode: TradeMode.custom));
  }

  TradeCustomSetting getCurrentTradeCustomSetting() {
    final customSetting = state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();

    return customSetting;
  }

  TradeMode getTradeMode() {
    final setting = getCurrentTradeCustomSetting();

    return setting.mode ?? TradeMode.fast;
  }

  Future<void> getUserTradeConfig() async {
    emit(state.copyWith(
        getTradeSettingStatus: const GetTradeSettingStatus.loading()));

    try {
      final tradeConfig =
          await getIt<UserApi>().getUserTradeConfig(state.network);

// 更新对应链的 name
      updateCustomSetting(tradeConfig.config);
      updateTradeMode(TradeMode.values.byName(tradeConfig.mode));
      updateNetwork(tradeConfig.network.toString());
    } catch (e, s) {
      emit(state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString())));

      await SentryService().reportError(e, s,
          tags: {"feature": "getUserTradeConfig"},
          extra: {"network": state.network});
    }
  }

  Future<void> updateTradeConfig() async {
    final tradeConfig = getCurrentTradeCustomSetting();

    try {
      await getIt<UserApi>().updateTradeConfig(
          network: state.network, mode: state.mode, config: tradeConfig);

      _saveSettings(state);
    } catch (e, s) {
      emit(state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString())));

      await SentryService().reportError(e, s, tags: {
        "feature": "updateTradeConfig"
      }, extra: {
        "chainName": state.network,
        "mode": state.mode,
        "config": tradeConfig.toString()
      });
    }
  }
}
