import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/intel/intel.dart';
import '../../data/models/token/query_token/query_token.dart';
import '../../data/models/transfer/index.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/decimal.dart';
import '../../utils/extensions/string.dart';
import '../../widgets/token/models/token.dart';

part 'trade_state.freezed.dart';

enum TradeStatus { none, paramsInvalid }

const TradeToken defaultTradeToken = TradeToken(
  isNative: false,
  chainId: '1151111081099710',
  chainLogo:
      'https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg',
  chainName: 'Solana',
  tokenAvatar:
      'https://static.oklink.com/cdn/web3/currency/token/large/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-107/type=default_90_0?v=1756203256814',
  tokenName: 'USDC',
  address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
  tokenPrice: 0,
  balance: '0',
  decimals: 6,
  network: 'solana',
  symbol: 'USDC',
);

const TradeToken defaultFormTradeToken = TradeToken(
  isNative: true,
  chainId: '1151111081099710',
  chainLogo:
      'https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg',
  chainName: 'Solana',
  tokenAvatar:
      'https://static.oklink.com/cdn/web3/currency/token/501-11111111111111111111111111111111-1.png/type=default_350_0?v=1734571825920',
  tokenName: 'SOL',
  address: '11111111111111111111111111111111',
  tokenPrice: 0,
  balance: '0',
  decimals: 9,
  network: 'solana',
  symbol: 'SOL',
);

const TradeToken defaultBNBTradeToken = TradeToken(
  isNative: true,
  chainId: '56',
  chainLogo: 'assets/chain/bsc.png',
  chainName: 'BNB Chain',
  tokenAvatar:
      'image/iFE4m6Yk_eFlSyQMfxs3JG63Y77FvV68mwVQOTV9Sb5zEo1BdDm495nIqzsWagZ6FO3Z17ORa-x9dos2k-ebsA==',
  tokenName: 'BNB',
  address: '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
  tokenPrice: 0,
  balance: '0',
  decimals: 9,
  network: 'bsc',
  symbol: 'BNB',
);

@freezed
sealed class GetTokenBalanceStatus with _$GetTokenBalanceStatus {
  const factory GetTokenBalanceStatus.initial() = _GetTokenBalanceInitial;
  const factory GetTokenBalanceStatus.loading() = _GetTokenBalanceLoading;
  const factory GetTokenBalanceStatus.success(String balance) =
      _GetTokenBalanceSuccess;
  const factory GetTokenBalanceStatus.failure() = _GetTokenBalanceFailure;
}

@freezed
sealed class QuoteStatus with _$QuoteStatus {
  const factory QuoteStatus.initial() = _QuoteInitial;
  const factory QuoteStatus.loading() = _QuoteLoading;
  const factory QuoteStatus.success(TransferQuote quote) = _QuoteSuccess;
  const factory QuoteStatus.failure() = _QuoteFailure;
}

@freezed
sealed class TradeParamsStatus with _$TradeParamsStatus {
  const factory TradeParamsStatus.initial() = _TradeParamsInitial;
  const factory TradeParamsStatus.loading() = _TradeParamsLoading;
  const factory TradeParamsStatus.success() = _TradeParamsSuccess;
  const factory TradeParamsStatus.failure() = _TradeParamsFailure;
}

@freezed
sealed class TradeStatusMessage with _$TradeStatusMessage {
  const factory TradeStatusMessage.initial() = _TradeStatusInitial;
  const factory TradeStatusMessage.loading() = _TradeStatusLoading;
  const factory TradeStatusMessage.success(TransferTransaction transaction) =
      _TradeStatusSuccess;
  const factory TradeStatusMessage.failure(TradeStatus failure) =
      _TradeStatusFailure;
}

@freezed
sealed class TradeGetBalanceStatus with _$TradeGetBalanceStatus {
  const factory TradeGetBalanceStatus.initial() = _TradeGetBalanceInitial;
  const factory TradeGetBalanceStatus.loading() = _TradeGetBalanceLoading;
  const factory TradeGetBalanceStatus.success(String balance) =
      _TradeGetBalanceSuccess;
  const factory TradeGetBalanceStatus.failure() = _TradeGetBalanceFailure;
}

@freezed
sealed class TradeToken with _$TradeToken {
  const TradeToken._();

  const factory TradeToken({
    @JsonKey(name: 'chain_id') required String chainId,
    // @JsonKey(name: "chain_name") String chainName,
    @JsonKey(name: 'chain_logo') required String chainLogo,
    @JsonKey(name: 'token_avatar') required String tokenAvatar,
    @JsonKey(name: 'token_name') required String tokenName,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'decimals') required int decimals,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'balance') String? balance,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'token_price') required double tokenPrice,
    @JsonKey(name: 'network') String? network,
    @JsonKey(name: 'is_native') required bool isNative,
    // @JsonKey(name: "amount") required String amount,
  }) = _TradeToken;

  String get unique {
    if (chainId.isEmpty || chainId == 'null') {
      return network ?? '';
    }
    return chainId;
  }

  static TradeToken empty() => const TradeToken(
    chainId: '',
    chainLogo: '',
    tokenAvatar: '',
    tokenName: '',
    address: '',
    decimals: 0,
    symbol: '',
    chainName: '',
    tokenPrice: 0,
    isNative: false,
  );

  factory TradeToken.fromToken(Token token) {
    return TradeToken(
      isNative: token.isNativeToken,
      chainId: token.chainId,
      chainLogo: token.chainLogo,
      tokenAvatar: token.tokenAvatar,
      tokenName: token.tokenName,
      address: token.address,
      decimals: token.decimals,
      symbol: token.symbol,
      chainName: token.chainName,
      network: token.network,
      tokenPrice: double.tryParse(token.tokenPrice) ?? 0,
      balance: token.balance,
    );
  }

  factory TradeToken.fromJson(Map<String, dynamic> json) {
    return TradeToken(
      isNative: json['is_navtive'],
      chainId: json['chain_id'],
      chainLogo: json['chain_logo'],
      tokenAvatar: json['token_avatar'],
      tokenName: json['token_name'],
      address: json['address'],
      decimals: json['decimals'],
      symbol: json['symbol'],
      chainName: json['chain_name'],
      network: json['network'],
      tokenPrice: json['token_price'],
      balance: json['balance'],
    );
  }

  factory TradeToken.fromEntity(Entity entity) {
    try {
      final token = TradeToken(
        isNative: entity.isNative ?? false,
        chainId: entity.chain?.networkId ?? '',
        chainLogo: entity.chain?.logo ?? '',
        chainName: entity.chain?.name ?? '',
        tokenAvatar: entity.logo ?? '',
        tokenName: entity.name ?? '',
        address: entity.contractAddress ?? '',
        tokenPrice: 0,
        balance: '',
        decimals: entity.decimals ?? 0,
        network: entity.chain?.slug ?? '',
        symbol: entity.symbol ?? '',
      );
      return token;
    } catch (e) {
      return const TradeToken(
        isNative: false,
        chainId: '',
        chainLogo: '',
        chainName: '',
        tokenAvatar: '',
        tokenName: '',
        address: '',
        tokenPrice: 0,
        balance: '',
        decimals: 0,
        network: '',
        symbol: '',
      );
    }
  }

  factory TradeToken.fromQueryToken(QueryToken token) {
    return TradeToken(
      isNative: token.isNative ?? false,
      chainId: token.networkId.toString(),
      chainLogo: token.networkLogo ?? '',
      tokenAvatar: token.logo ?? '',
      tokenName: token.name ?? '',
      address: token.address ?? '',
      decimals: token.decimals ?? 0,
      symbol: token.symbol ?? '',
      chainName: token.networkName ?? '',
      network: token.network ?? '',
      tokenPrice: double.tryParse(token.priceUsd ?? '0') ?? 0,
    );
  }
}

@freezed
sealed class TradeState with _$TradeState {
  const TradeState._();
  const factory TradeState({
    @Default(TradeStatusMessage.initial()) TradeStatusMessage status,
    @Default(QuoteStatus.initial()) QuoteStatus quoteStatus,
    @Default(100) int slippage,
    @Default(0) int priorityFee,
    @Default('0') String amount,
    @Default(null) TransferQuote? quote,
    @Default([]) List<Token> availableTokens,
    @Default(defaultFormTradeToken) TradeToken? fromToken,
    @Default(defaultTradeToken) TradeToken? toToken,
    @Default(null) TextEditingController? amountController,
    @Default(TradeParamsStatus.initial()) TradeParamsStatus paramsStatus,
    @Default([]) List<Token> nativeTokens,
    @Default(null) String? toAmount,
    @Default(null) double? fromBalance,
    @Default(GetTokenBalanceStatus.initial())
    GetTokenBalanceStatus fromBalanceStatus,
    @Default(null) DateTime? lastQuoteTimestamp,
  }) = _TradeState;

  factory TradeState.initial() =>
      TradeState(amountController: TextEditingController(text: '0'));
}

class TradeButtonConfig {
  final bool isEnabled;
  final bool isLoading;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final Widget? icon;
  final VoidCallback? onPressed;

  const TradeButtonConfig({
    required this.isEnabled,
    required this.isLoading,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.iconColor,
    this.icon,
    this.onPressed,
  });
}

/// Extension for button state computation
extension TradeStateButtonExtension on TradeState {
  /// Compute the button state based on current trade state
  /// This provides a single source of truth for button UI logic
  /// Note: Fee validation requires access to nativeTokens which is not available here
  /// The complete button state with fee validation should be computed in TradeCubit
  TradeButtonState get baseButtonState {
    // 1️⃣ Highest priority: Trading in progress
    final isTrading = status.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isTrading) {
      return const TradeButtonState.trading();
    }

    // 2️⃣ Second priority: Quote loading
    final isQuoteLoading = quoteStatus.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );
    if (isQuoteLoading) {
      return const TradeButtonState.quoteLoading();
    }

    // 3️⃣ Collect all disabled reasons
    final List<TradeButtonDisabledReason> reasons = [];

    // Check: Has amount been entered
    if (!amount.isNotEmptyAndZeroValue) {
      reasons.add(const TradeButtonDisabledReason.noAmount());
    }

    // Check: Are different tokens selected
    if (fromToken?.address == toToken?.address &&
        fromToken?.chainId == toToken?.chainId) {
      reasons.add(const TradeButtonDisabledReason.sameToken());
    }

    // Check: Params validation status
    final isParamsInvalid = paramsStatus.maybeWhen(
      failure: () => true,
      orElse: () => false,
    );
    if (isParamsInvalid) {
      reasons.add(const TradeButtonDisabledReason.invalidParams());
    }

    // Check: Amount validity after decimal conversion
    // Convert to atomic units to ensure the amount is not too small
    if (amount.isNotEmptyAndZeroValue) {
      try {
        final atomicAmount = multiplyByDecimalPower(
          amount,
          fromToken?.decimals ?? 18,
        );
        if (atomicAmount == BigInt.zero) {
          reasons.add(const TradeButtonDisabledReason.invalidAmount());
        }
      } catch (e) {
        // If conversion fails, the amount is invalid
        reasons.add(const TradeButtonDisabledReason.invalidAmount());
      }
    }

    // Check: Balance sufficiency
    if (amount.isNotEmptyAndZeroValue && fromBalance != null) {
      final amountValue = double.tryParse(amount) ?? 0.0;
      final balanceValue = fromBalance ?? 0.0;
      if (amountValue > balanceValue) {
        reasons.add(TradeButtonDisabledReason.insufficientBalance(
          tokenSymbol: fromToken?.symbol ?? '',
        ));
      }
    }

    // Check: Quote status (only when amount is valid)
    if (amount.isNotEmptyAndZeroValue) {
      final hasQuote = quoteStatus.maybeWhen(
        success: (_) => quote != null,
        orElse: () => false,
      );
      final quoteFailed = quoteStatus.maybeWhen(
        failure: () => true,
        orElse: () => false,
      );

      if (quoteFailed) {
        reasons.add(const TradeButtonDisabledReason.quoteFailed());
      } else if (!hasQuote) {
        reasons.add(const TradeButtonDisabledReason.noQuote());
      }
    }

    // 4️⃣ Return result
    if (reasons.isEmpty) {
      return const TradeButtonState.ready();
    }

    // Sort by priority and return highest priority reason
    reasons.sort((a, b) => b.priority.compareTo(a.priority));
    return TradeButtonState.disabled(reason: reasons.first);
  }
}
