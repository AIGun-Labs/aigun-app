import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/models/wallet/token/token.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/storage/local/settings_storage.dart';
import '../index.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit(this.walletCubit, this._settingsStorage)
    : super(const BalanceState()) {
    walletSubscription = walletCubit.stream.listen((state) {
      if (state.wallets.isNotEmpty) {
        getBalanceList();
        startPollingBalance();
      }
    });
    _initHideSmallAssets();
  }
  final WalletApi walletApi = getIt<WalletApi>();
  final WalletCubit walletCubit;
  final SettingsStorage _settingsStorage;
  late final StreamSubscription walletSubscription;
  PollingService<Balance?>? _pollingService;
  void startPollingBalance() {
    return;
  }

  void stopPollingBalance() {
    return;
  }

  void clearBalance() {
    emit(
      state.copyWith(
        balances: null,
        filteredTokens: [],
        searchQuery: '',
        hideSmallAssets: false,
      ),
    );
  }

  List<Token>? getSortedTokens(List<Token>? tokens) {
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

  void _initHideSmallAssets() {
    final hideSmallAssets = _settingsStorage.hideSmallAssets;
    emit(state.copyWith(hideSmallAssets: hideSmallAssets));
    _updateFilteredTokens(state.balances);
  }

  Future<Balance?> getBalanceList() async {
    return null;
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
    if (state.hideSmallAssets) {
      filteredTokens = filteredTokens.where((token) {
        final value = double.tryParse(token.balance) ?? 0;
        return value > 1; //  1
      }).toList();
    }
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filteredTokens = filteredTokens.where((token) {
        final symbolMatch = token.symbol.toLowerCase().startsWith(query);
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
      SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getBalance'},
        extra: {'address': tokenAddress, 'chainId': chainId},
      );
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

    final matches = tokens.where(
      (token) =>
          token.network.toLowerCase() == normalizedNetwork &&
          token.tokenAddress.toLowerCase() == normalizedAddress,
    );

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
      SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenInfo'},
        extra: {'address': tokenAddress, 'chainId': chainId},
      );
      return null;
    }
  }

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
      SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getChainLogoByAddress'},
        extra: {'address': tokenAddress, 'chainId': chainId},
      );
      return null;
    }
  }

  String? getNativeBalance(String network, {String? name}) {
    return state.balances?.tokens
            .firstWhereOrNull(
              (token) =>
                  token.network == network &&
                  (token.isNative == true || token.tokenName == name),
            )
            ?.balance ??
        '';
  }

  @override
  Future<void> close() {
    walletSubscription.cancel();
    return super.close();
  }
}
