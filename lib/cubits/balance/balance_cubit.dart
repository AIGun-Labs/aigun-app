import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/models/wallet/token/token.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/storage/local/settings_storage.dart';
import '../index.dart';

class BalanceCubit extends Cubit<BalanceState> {
  final WalletApi walletApi = getIt<WalletApi>();
  final WalletCubit walletCubit;
  final SettingsStorage _settingsStorage;
  late final StreamSubscription walletSubscription;
  PollingService<Balance?>? _pollingService;

  BalanceCubit(this.walletCubit, this._settingsStorage)
      : super(const BalanceState()) {
    // 监听钱包列表
    walletSubscription = walletCubit.stream.listen((state) {
      // 如果不为空，则获取余额
      if (state.wallets.isNotEmpty) {
        // 先获取一次
        getBalanceList();
        startPollingBalance();
      }
    });
    _initHideSmallAssets();
  }

  void startPollingBalance() {
    _pollingService?.stop();
    _pollingService = PollingService<Balance?>(
      baseInterval: const Duration(seconds: FIVE),
      maxInterval: const Duration(minutes: ONE),
      fetcher: (cancel) async {
        final previousBalance = state.balances;

        emit(state.copyWith(isLoading: true, balances: previousBalance));

        if (walletCubit.state.wallets.first.id == null) {
          emit(state.copyWith(
              hasError: true, errorMessage: 'Wallet ID is null'));
          return null;
        }
        final balance = await getBalanceList();
        return balance;
      },
      onData: (balance) async {
        emit(state.copyWith(
          balances: balance,
          isLoading: false,
          hasError: false,
          errorMessage: null,
          // sortedTokens: getSortedTokens(balance.tokens) ?? [],
        ));

        await getIt<TradeCubit>().getBalanceSelectedToken();
      },
    );
    _pollingService?.start();
  }

  void stopPollingBalance() {
    _pollingService?.stop();
  }

  void clearBalance() {
    emit(state.copyWith(
        balances: null,
        filteredTokens: [],
        searchQuery: '',
        hideSmallAssets: false));
  }

  List<Token>? getSortedTokens(List<Token>? tokens) {
    // 拷贝
    final List<Token> sortedTokens = [...tokens ?? []];

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
  Future<Balance?> getBalanceList() async {
    final previousBalance = state.balances;
    Balance? balance;

    emit(state.copyWith(isLoading: true, balances: previousBalance));

    if (walletCubit.state.wallets.first.id == null) {
      emit(state.copyWith(hasError: true, errorMessage: 'Wallet ID is null'));
      return null;
    }
    // 获取钱包列表中第一个钱包的 id
    final walletId = walletCubit.state.wallets.first.id ?? '';
    try {
      // 获取钱包余额
      balance = await walletApi.getBalanceByWalletId(walletId);
      emit(state.copyWith(
        balances: balance,
        isLoading: false,
        hasError: false,
        errorMessage: null,
        // sortedTokens: getSortedTokens(balance.tokens) ?? [],
      ));

      await getIt<TradeCubit>().getBalanceSelectedToken();
      // 更新过滤后的代币列表
      // _updateFilteredTokens(balance);
    } catch (e, s) {
      emit(state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
        isLoading: false,
      ));
      await SentryService().reportError(e, s,
          tags: {'feature': 'getBalanceList'}, extra: {'walletId': walletId});
      return null;
    }
    return balance;
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

  Token? getBalance(String tokenAddress, String chainId) {
    if (state.balances?.tokens == null || state.balances!.tokens.isEmpty) {
      return null;
    }

    try {
      final token = state.balances?.tokens.firstWhere(
        (token) =>
            token.tokenAddress == tokenAddress && token.chainId == chainId,
      );

      return token;
    } catch (e, s) {
      SentryService().reportError(e, s,
          tags: {'feature': 'getBalance'},
          extra: {'address': tokenAddress, 'chainId': chainId});
      return null;
    }
  }

  num getTokenBalance(String? address, String? network) {
    final tokens = state.balances?.tokens ?? [];
    if (tokens.isEmpty) {
      return 0;
    }

    final normalizedAddress = address?.toLowerCase();
    final normalizedNetwork = network?.toLowerCase();

    final matches = tokens.where((token) =>
        token.network.toLowerCase() == normalizedNetwork &&
        token.tokenAddress.toLowerCase() == normalizedAddress);

    if (matches.isEmpty) {
      return 0;
    }

    return double.tryParse(matches.first.balance) ?? 0;
  }

  Token? getTokenInfo(String tokenAddress, String chainId) {
    if (state.balances?.tokens == null || state.balances!.tokens.isEmpty) {
      return null;
    }

    try {
      return state.balances!.tokens.firstWhere(
        (token) =>
            token.tokenAddress == tokenAddress && token.chainId == chainId,
        orElse: () => throw StateError('No element found'),
      );
    } catch (e, s) {
      SentryService().reportError(e, s,
          tags: {'feature': 'getTokenInfo'},
          extra: {'address': tokenAddress, 'chainId': chainId});
      return null;
    }
  }

  /// 根据代币地址和链 ID 获取对应的链头像
  String? getChainLogoByAddress(String tokenAddress, String chainId) {
    if (state.balances?.tokens == null || state.balances!.tokens.isEmpty) {
      return null;
    }

    try {
      final token = state.balances?.tokens.firstWhere(
        (token) =>
            token.tokenAddress == tokenAddress && token.chainId == chainId,
      );

      return token?.chainLogo;
    } catch (e, s) {
      SentryService().reportError(e, s,
          tags: {'feature': 'getChainLogoByAddress'},
          extra: {'address': tokenAddress, 'chainId': chainId});
      return null;
    }
  }

  @override
  Future<void> close() {
    walletSubscription.cancel();
    return super.close();
  }
}
