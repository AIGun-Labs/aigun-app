// lib/core/domain/interfaces/i_token.dart

abstract interface class IToken {
  String get chainId;

  String get chainLogo;

  String get chainName;

  String get network;

  /// Token Logo URL
  String get tokenLogo;

  String get tokenName;

  String get symbol;

  String get address;

  int get decimals;

  bool get isNative;

  String get tokenPrice;

  String get priceChange24h;

  String get marketCap;

  String get rawBalance;

  String get balance;
}

abstract interface class ITokenFactory<T extends IToken> {
  T createEmpty();
}
