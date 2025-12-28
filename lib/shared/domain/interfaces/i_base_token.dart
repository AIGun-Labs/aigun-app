// lib/core/domain/interfaces/i_token.dart

abstract interface class IBaseToken {
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
  String get price;
  String get priceChange24h;
  String get marketCap;
  String get liquidity;
  String get volume24h;
  String get rawBalance;
  String get balance;

  String? get balanceUsd;
  String? get description;
  String? get standard;
  DateTime? get displayTime;
  bool? get isVerified;
  String? get type;
  bool? get isTop;
}

abstract interface class ITokenFactory<T extends IBaseToken> {
  T createEmpty();
}
