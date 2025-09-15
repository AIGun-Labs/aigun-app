import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/utils/storage/local/settings_storage.dart';
import 'package:get_it/get_it.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final WalletApi walletApi = GetIt.instance<WalletApi>();
  final WalletCubit walletCubit;
  final SettingsStorage _settingsStorage;
  late final StreamSubscription walletSubscription;

  Timer? _timer;

  BalanceCubit(this.walletCubit, this._settingsStorage)
      : super(const BalanceState()) {
    // 监听钱包列表
    walletSubscription = walletCubit.stream.listen((state) {
      _timer?.cancel();
      // 如果不为空，则获取余额
      if (state.wallets.isNotEmpty) {
        // 先获取一次
        getBalanceList();
        // 周期性定时器，每隔 5 秒钟执行一次，每次都调用 getBalanceList() 方法 获取最新的余额
        _timer = Timer.periodic(const Duration(milliseconds: 5000), (timer) {
          getBalanceList();
        });
      }
    });
    _initHideSmallAssets();
  }

  List<Token> getSortedTokens() {
    // 拷贝
    final List<Token> sortedTokens = [...state.balances?.tokens ?? []];

    if (sortedTokens.isEmpty == true) {
      return [];
    }

    sortedTokens.sort((a, b) {
      double aBalance = double.tryParse(a.balance) ?? 0;
      double bBalance = double.tryParse(b.balance) ?? 0;
      return bBalance.compareTo(aBalance);
    });

    return sortedTokens;
  }

// 初始化隐藏小额资产
  void _initHideSmallAssets() {
    // 从本地存储中获取是否隐藏小额资产
    final hideSmallAssets = _settingsStorage.hideSmallAssets;
    emit(state.copyWith(hideSmallAssets: hideSmallAssets));
    _updateFilteredTokens(state.balances);
  }

  // 获取余额列表
  Future<void> getBalanceList() async {
    final previousBalance = state.balances;

    emit(state.copyWith(isLoading: true, balances: previousBalance));

    if (walletCubit.state.wallets.first.id == null) {
      emit(state.copyWith(hasError: true, errorMessage: 'Wallet ID is null'));
      return;
    }

    try {
      // 获取钱包列表中第一个钱包的 id
      final walletId = walletCubit.state.wallets.first.id!;
      // 获取钱包余额
      final balance = await walletApi.getBalanceByWalletId(walletId);

      emit(state.copyWith(
        balances: balance,
        isLoading: false,
        hasError: false,
        errorMessage: null,
      ));

      // 更新过滤后的代币列表
      _updateFilteredTokens(balance);
    } catch (e) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
        isLoading: false,
      ));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _updateFilteredTokens(state.balances);
  }

  Future<void> toggleHideSmallAssets() async {
    final newValue = !state.hideSmallAssets;
    await _settingsStorage.setHideSmallAssets(newValue);
    emit(state.copyWith(hideSmallAssets: newValue));
    _updateFilteredTokens(state.balances);
  }

  Future<void> setHideSmallAssets(bool value) async {
    await _settingsStorage.setHideSmallAssets(value);
    emit(state.copyWith(hideSmallAssets: value));
    _updateFilteredTokens(state.balances);
  }

  void _updateFilteredTokens(Balance? balance) {
    if (balance == null) {
      emit(state.copyWith(filteredTokens: []));
      return;
    }

    List<Token> filteredTokens = balance.tokens;

    // 先应用小额资产过滤
    if (state.hideSmallAssets) {
      // 过滤掉价值小于 1 的代币
      filteredTokens = filteredTokens.where((token) {
        final value = double.tryParse(token.balance) ?? 0;
        return value > 1; // 过滤掉价值小于 1 的代币
      }).toList();
    }

    // 再应用搜索过滤
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filteredTokens = filteredTokens.where((token) {
        // 按照symbol进行前缀匹配
        final symbolMatch = token.symbol.toLowerCase().startsWith(query);

        // 按照地址进行精确匹配
        final addressMatch = token.tokenAddress.toLowerCase() == query;

        return symbolMatch || addressMatch;
      }).toList();
    }

    emit(state.copyWith(filteredTokens: filteredTokens));
  }

  double getTotalValue() {
    final totalValue = state.balances?.tokens.fold(0.0, (sum, token) {
      final value = double.tryParse(token.balance) ?? 0;
      return sum + value;
    });
    return totalValue ?? 0;
  }

  Token? getBalance(String tokenAddress, int chainId) {
    if (state.balances?.tokens == null || state.balances!.tokens.isEmpty) {
      return null;
    }

    try {
      final token = state.balances?.tokens.firstWhere(
        (token) =>
            token.tokenAddress == tokenAddress && token.chainId == chainId,
      );

      return token;
    } catch (e) {
      return null;
    }
  }

  Token? getTokenInfo(String tokenAddress, int chainId) {
    if (state.balances?.tokens == null || state.balances!.tokens.isEmpty) {
      return null;
    }

    try {
      return state.balances!.tokens.firstWhere(
        (token) =>
            token.tokenAddress == tokenAddress && token.chainId == chainId,
        orElse: () => throw StateError('No element found'),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> close() {
    walletSubscription.cancel();
    _timer?.cancel();
    return super.close();
  }
}
