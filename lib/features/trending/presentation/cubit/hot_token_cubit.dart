import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/logger.dart';
import '../../domain/usecases/fetch_hot_tokens.dart';
import '../../domain/usecases/fetch_networks.dart';
import 'hot_token_state.dart';

/// 热门代币 Cubit
class HotTokenCubit extends Cubit<HotTokenState> {
  final FetchHotTokens _fetchHotTokens;
  final FetchNetworks _fetchNetworks;
  String _selectedNetwork = 'all';
  Map<String, String> _supportedNetworks = {};

  HotTokenCubit(
    this._fetchHotTokens,
    this._fetchNetworks,
  ) : super(const HotTokenState.initial());

  /// 获取支持的网络列表
  Future<Map<String, String>> getSupportedNetworks() async {
    try {
      final networksEntity = await _fetchNetworks.call();
      _supportedNetworks = networksEntity.networks;
      return _supportedNetworks;
    } catch (e) {
      Logger.error('Failed to fetch supported networks: $e');
      return {};
    }
  }

  /// 加载初始数据
  Future<void> loadInitial({String network = 'all'}) async {
    // 保留旧数据
    final previousTokens = state.maybeWhen(
      loaded: (tokens, _) => tokens,
      orElse: () => null,
    );

    emit(HotTokenState.loading(
      previousTokens: previousTokens,
      selectedNetwork: network,
    ));

    _selectedNetwork = network;

    try {
      final tokens = await _fetchHotTokens(_selectedNetwork);
      Logger.info('tokens: $tokens');
      if (tokens.isEmpty) {
        emit(HotTokenState.empty(selectedNetwork: _selectedNetwork));
      } else {
        emit(HotTokenState.loaded(
            tokens: tokens, selectedNetwork: _selectedNetwork));
      }
    } catch (e) {
      emit(HotTokenState.error(
        message: e.toString(),
        selectedNetwork: _selectedNetwork,
      ));
    }
  }

  /// 刷新（下拉刷新）
  Future<void> refresh() async {
    await loadInitial(network: _selectedNetwork);
  }

  /// 切换网络筛选
  Future<void> selectNetwork(String network) async {
    if (_selectedNetwork == network) return;

    _selectedNetwork = network;

    await loadInitial(network: network);
  }

  /// 获取当前选中的网络
  String get selectedNetwork => _selectedNetwork;

  /// 获取支持的网络列表
  Map<String, String> get supportedNetworks => _supportedNetworks;
}
