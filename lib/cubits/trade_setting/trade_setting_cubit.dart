import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../data/models/index.dart';
import '../../data/models/trade/setting/trade_custom_setting.dart';
import '../../data/services/sentry_service.dart';
import '../../enums/trade_mode.dart';
import '../../features/auth/infrastructure/datasources/user_remote_source.dart';
import '../../shared/utils/safe_request.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/trade_setting.dart';
import 'trade_setting_state.dart';

class TradeSettingCubit extends Cubit<TradeSettingState> {
  TradeSettingCubit(this._storage, this._userRemoteSource)
    : super(TradeSettingState.initial());
  final TradeSettingStorage _storage;
  final UserRemoteSource _userRemoteSource;

  PollingService? _pollingService;
  // final SwapCubit _swapCubit;
  Timer? _timer;

  Future<void> init() async {
    await getUserTradeConfig();

    // await _loadSettings();
  }

  void startPollingLiveData() {
    _pollingService?.stop();

    _pollingService = PollingService(
      baseInterval: const Duration(seconds: THIRTY),
      maxInterval: const Duration(seconds: TEN),

      fetcher: (cancel) async {
        emit(
          state.copyWith(liveDataStatus: const TradeLiveDataStatus.loading()),
        );
        return await getTradeLiveData();
      },
      onError: (error, stack) {
        Logger.error('getTradeLiveData error: $error');
        emit(
          state.copyWith(
            liveDataStatus: const TradeLiveDataStatus.error('error'),
          ),
        );
      },
      onData: (liveData) {
        emit(
          state.copyWith(
            liveData: liveData,
            liveDataStatus: TradeLiveDataStatus.success(liveData),
          ),
        );
      },
    );

    _pollingService?.start();
  }

  void stopPollingLiveData() {
    _pollingService?.stop();
    _pollingService = null;
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
    return _userRemoteSource.getTradeLiveData(state.network);
  }

  Future<void> updateNetwork(String network, {bool forceUpdate = true}) async {
    final networkLower = network.toLowerCase();
    if (state.network != networkLower) {
      emit(state.copyWith(network: networkLower));
    }
    if (!forceUpdate) return;
    Logger.info('forceUpdate');

    final newCustomSetting = getTradeCustomSettingByNetwork(network);
    final liveData = await safeRequest(
      () => _userRemoteSource.getTradeLiveData(networkLower),
    );
    final newCustomSettings = Map<String, TradeCustomSetting>.from(
      state.customSettings,
    );
    newCustomSettings[networkLower] = newCustomSetting;
    if (liveData != null) {
      emit(
        state.copyWith(
          network: networkLower,
          customSettings: newCustomSettings,
          liveData: liveData,
          liveDataStatus: TradeLiveDataStatus.success(liveData),
        ),
      );
    } else {
      emit(
        state.copyWith(
          network: networkLower,
          customSettings: newCustomSettings,
        ),
      );
    }
  }

  Future<void> _saveSettings(TradeSettingState tradeSettingState) async {
    try {
      await _storage.saveTradeSetting(tradeSettingState.toJson());

      emit(state);
    } catch (e, s) {
      emit(
        state.copyWith(tradeSettingStatus: const TradeSettingStatus.error()),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': '_saveSettings'},
      );
    }
  }

  // update trade mode
  void updateTradeMode(TradeMode mode) {
    final currentCustom =
        state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mode: mode);
    updateCustomSetting(newCustom);
  }

  // update custom setting
  void updateCustomSetting(TradeCustomSetting setting) {
    final newCustomSettings = Map<String, TradeCustomSetting>.from(
      state.customSettings,
    );
    newCustomSettings[state.network.toLowerCase()] = setting;

    emit(state.copyWith(customSettings: newCustomSettings));
  }

  void updateCustomSettingForNetwork(
    String networkKey,
    TradeCustomSetting setting,
  ) {
    final newCustomSettings = Map<String, TradeCustomSetting>.from(
      state.customSettings.isEmpty ? defaultSettings : state.customSettings,
    );

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
      updateTradeMode(TradeMode.custom);
    }
  }

  // update mev protect
  void updateMevProtect(bool mevProtect) {
    final currentCustom =
        state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();
    final newCustom = currentCustom.copyWith(mevProtect: mevProtect);
    updateCustomSetting(newCustom);
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
    final customSetting =
        state.customSettings[state.network.toLowerCase()] ??
        const TradeCustomSetting();

    return customSetting;
  }

  TradeMode getTradeMode() {
    final setting = getCurrentTradeCustomSetting();

    return setting.mode ?? TradeMode.fast;
  }

  Future<void> getUserTradeConfig() async {
    emit(
      state.copyWith(
        getTradeSettingStatus: const GetTradeSettingStatus.loading(),
      ),
    );

    try {
      final tradeConfig = await _userRemoteSource.getUserTradeConfig(
        state.network,
      );
      updateCustomSetting(tradeConfig.config);
      updateTradeMode(TradeMode.values.byName(tradeConfig.mode));
      updateNetwork(tradeConfig.network.toString());
    } catch (e, s) {
      emit(
        state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString()),
        ),
      );

      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getUserTradeConfig'},
        extra: {'network': state.network},
      );
    }
  }

  Future<void> updateTradeConfig() async {
    final tradeConfig = getCurrentTradeCustomSetting();

    try {
      await _userRemoteSource.updateTradeConfig(
        network: state.network,
        mode: state.mode,
        config: tradeConfig,
      );

      _saveSettings(state);
    } catch (e, s) {
      emit(
        state.copyWith(
          getTradeSettingStatus: GetTradeSettingStatus.error(e.toString()),
        ),
      );
    }
  }
}
