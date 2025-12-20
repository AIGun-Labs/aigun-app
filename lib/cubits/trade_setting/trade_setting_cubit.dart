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

  // 不能这样写是因为 quick trade cubit 也需要 不能使用 stream
  // final SwapCubit _swapCubit;
  // 移除 _tradeCubit 字段，改为延迟获取以避免循环依赖
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
    // 使用 TradeSettingCubit 自己维护的 network 状态
    return _userRemoteSource.getTradeLiveData(state.network);
  }

  Future<void> updateNetwork(String network, {bool forceUpdate = true}) async {
    final networkLower = network.toLowerCase();

    // 1. 立即更新网络状态，确保 UI 响应 (Optimistic Update)
    // 即使不等待此方法完成，UI 也能拿到正确的 network
    if (state.network != networkLower) {
      emit(state.copyWith(network: networkLower));
    }

    // 如果不需要强制刷新则返回
    if (!forceUpdate) return;
    Logger.info('forceUpdate');

    final newCustomSetting = getTradeCustomSettingByNetwork(network);

    // 使用新的 network 获取 liveData
    final liveData = await safeRequest(
      () => _userRemoteSource.getTradeLiveData(networkLower),
    );

    // 准备更新的 customSettings
    final newCustomSettings = Map<String, TradeCustomSetting>.from(
      state.customSettings,
    );
    newCustomSettings[networkLower] = newCustomSetting;

    // 一次性 emit 所有更新，避免多次 emit 导致状态不一致
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

  /// 为指定网络更新自定义设置
  void updateCustomSettingForNetwork(
    String networkKey,
    TradeCustomSetting setting,
  ) {
    // 确保初始化了所有网络的默认设置
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
      // 操作 slippage 时，更新 mode 为 custom
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

      // 更新对应链的 name
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
