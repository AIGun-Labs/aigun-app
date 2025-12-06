import 'package:flutter/widgets.dart';

import '../../widgets/token/models/token.dart';

class TokenHandler {
  static Token? getNativeFromBalance({
    required String? network,
    required List<Token>? balances,
  }) {
    if (network == null || balances == null) return null;

    return balances
        .where((token) => token.isNative && token.network == network)
        .firstOrNull;
  }

  static List<Token> filterToken(
    List<Token> tokens,
    List<(String, String)> filterTokens,
  ) {
    return tokens
        .where(
          (token) => filterTokens.any(
            (element) =>
                element.$1 == token.address && element.$2 == token.network,
          ),
        )
        .toList();
  }

  static bool isSupportedChain({
    required String network,
    required String address,
    required List<String> supportedChains,
  }) {
    return supportedChains.contains(network);
  }

  /// 是否不支持这条链进行交易
  static bool isUnsupportedChain({
    required String network,
    required String address,
    required List<String> supportedChains,
  }) {
    return !isSupportedChain(
      network: network,
      address: address,
      supportedChains: supportedChains,
    );
  }

  static List<Token> excludeUnsupportedToken(
    List<Token> tokens,
    List<String> supportedChains,
  ) {
    return tokens
        .where(
          (token) => isSupportedChain(
            network: token.network ?? '',
            address: token.address,
            supportedChains: supportedChains,
          ),
        )
        .toList();
  }

  static void executeIfSupported({
    required bool isSupported,
    required VoidCallback onSupported,
  }) {
    if (isSupported) {
      onSupported();
    }
  }
}
