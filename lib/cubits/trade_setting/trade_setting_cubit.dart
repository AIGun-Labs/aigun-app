import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeSettingCubit extends Cubit<TradeSettingState> {
  final TradeSettingStorage _storage;

  TradeSettingCubit(this._storage) : super(TradeSettingState.initial()) {
    _loadSettings();
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
    emit(state);
  }

// update trade mode
  void updateTradeMode(TradeMode mode) {
    _saveSettings(state.copyWith(mode: mode));
  }

// update custom setting
  void updateCustomSetting(int? chainId, TradeCustomSetting setting) {
    if (chainId == null) {
      return;
    }
    final newCustomSettings =
        Map<int, TradeCustomSetting>.from(state.customSettings);
    newCustomSettings[chainId] = setting;

    _saveSettings(state.copyWith(customSettings: newCustomSettings));
  }

// update slippage
  void updateSlippage(int? chainId, String slippage) {
    if (chainId == null) {
      return;
    }
    final currentCustom =
        state.customSettings[chainId] ?? const TradeCustomSetting();

    final newCustom = currentCustom.copyWith(slippage: slippage);
    updateCustomSetting(chainId, newCustom);
  }

// update mev protect
  void updateMevProtect(int? chainId, bool mevProtect) {
    if (chainId == null) {
      return;
    }
    final currentCustom =
        state.customSettings[chainId] ?? const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mevProtect: mevProtect);
    updateCustomSetting(chainId, newCustom);
  }

  bool getMevProtect(int? chainId) {
    return state.customSettings[chainId]?.mevProtect ?? false;
  }

  void resetAll() {
    _saveSettings(TradeSettingState.initial());
  }
}
