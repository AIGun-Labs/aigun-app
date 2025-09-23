import 'package:flutter_aigun/config/chain.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/models/user/trade_config/trade_config.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeSettingCubit extends Cubit<TradeSettingState> {
  final TradeSettingStorage _storage;

  TradeSettingCubit(this._storage) : super(TradeSettingState.initial()) {
    init();
  }

  Future<void> init() async {
    await getUserTradeConfig();
    await _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final settingsJson = await _storage.getTradeSetting();

      if (settingsJson != null) {
        final settings = TradeSettingState.fromJson(settingsJson);
        emit(settings);
      }
    } catch (e) {
      // Handle error or use default
    }
  }

  Future<void> _saveSettings(TradeSettingState state) async {
    await _storage.saveTradeSetting(state.toJson());
    // update trade config
    emit(state);
  }

// update trade mode
  void updateTradeMode(TradeMode mode) {
    // update trade config
    _saveSettings(state.copyWith(mode: mode));
  }

// update custom setting
  void updateCustomSetting(TradeCustomSetting setting) {
    final newCustomSettings =
        Map<String, TradeCustomSetting>.from(state.customSettings);
    newCustomSettings[state.chainName] = setting;

    _saveSettings(state.copyWith(customSettings: newCustomSettings));
  }

  TradeCustomSetting getTradeCustomSettingByChainName(String chainName) {
    return state.customSettings[chainName] ?? const TradeCustomSetting();
  }

// update slippage
  void updateSlippage(int slippage) {
    final newCustom =
        state.customSettings[state.chainName]?.copyWith(slippage: slippage);

    updateCustomSetting(newCustom!);
  }

// update mev protect
  void updateMevProtect(bool mevProtect) {
    final currentCustom =
        state.customSettings[state.chainName] ?? const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mevProtect: mevProtect);
    updateCustomSetting(newCustom);
  }

  bool getMevProtect() {
    return state.customSettings[state.chainName]?.mevProtect ?? false;
  }

  void resetAll() {
    _saveSettings(TradeSettingState.initial());
  }

  TradeCustomSetting getCurrentTradeCustomSetting() {
    return state.customSettings[state.chainName] ?? const TradeCustomSetting();
  }

  TradeMode getTradeMode() {
    return state.mode;
  }

  Future<void> getUserTradeConfig() async {
    emit(state.copyWith(
        getTradeSettingStatus: const GetTradeSettingStatus.loading()));

    try {
      final tradeConfig = await getIt<UserApi>().getUserTradeConfig();

      // convert mode to TradeMode
      final mode = TradeMode.values.byName(tradeConfig.mode);

// 更新对应链的 name
      updateCustomSetting(tradeConfig.config);

      emit(state.copyWith(
          mode: mode,
          chainName: tradeConfig.chainName,
          getTradeSettingStatus: GetTradeSettingStatus.success(tradeConfig)));
    } catch (e) {
      emit(state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString())));
    }
  }

  Future<void> updateTradeConfig(TradeConfig tradeConfig) async {
    try {
      await getIt<UserApi>().updateTradeConfig(tradeConfig);
    } catch (e) {
      emit(state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString())));
    }
  }
}
