import 'package:flutter/material.dart';

///
class TokenCardConfig {
  final String symbol;
  final String tokenName;
  final String tokenAvatar;
  final String chainLogo;
  final String chainName;
  final String dollarValue;
  final String? amount;
  final int decimals;
  final bool isNative;

  const TokenCardConfig({
    required this.symbol,
    required this.tokenName,
    required this.tokenAvatar,
    required this.chainLogo,
    required this.chainName,
    required this.dollarValue,
    required this.decimals,
    required this.isNative,
    this.amount,
  });
  bool get hasSelectedToken => tokenName.isNotEmpty;
  factory TokenCardConfig.empty() => const TokenCardConfig(
    symbol: '',
    tokenName: '',
    tokenAvatar: '',
    chainLogo: '',
    chainName: '',
    dollarValue: '',
    decimals: 0,
    isNative: false,
  );
}

class TokenCardInteraction {
  final bool isEditable;
  final bool isSourceToken;
  final VoidCallback? onSelectToken;
  final ValueChanged<String>? onAmountChanged;
  final TextEditingController? amountController;

  const TokenCardInteraction({
    this.isEditable = false,
    this.isSourceToken = false,
    this.onSelectToken,
    this.onAmountChanged,
    this.amountController,
  });
}
