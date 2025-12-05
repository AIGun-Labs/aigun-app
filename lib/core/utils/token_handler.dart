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
}
