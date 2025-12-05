// lib/core/domain/interfaces/i_token.dart

abstract interface class IToken<TExtra> {
  // ==================== 链信息 ====================
  /// 链 ID
  String get chainId;

  /// 链 Logo URL
  String get chainLogo;

  /// 链名称
  String get chainName;

  /// 网络标识 (如: ethereum, bsc)
  String get network;

  // ==================== Token 基础信息 ====================
  /// Token Logo URL
  String get tokenLogo;

  /// Token 名称
  String get tokenName;

  /// Token 符号 (如: ETH, BTC)
  String get symbol;

  /// 合约地址
  String get address;

  /// 精度
  int get decimals;

  /// 是否是原生代币
  bool get isNative;

  // ==================== 价格信息 ====================
  /// Token 价格 (USD)
  String get tokenPrice;

  /// 24小时价格变化百分比
  String get priceChange24h;

  /// 市值
  String get marketCap;

  /// 流动性
  String get liquidity;

  /// 24小时交易量
  String get volume24h;

  // ==================== 余额信息 ====================
  /// 原始余额 (包含精度)
  String get rawBalance;

  /// 格式化余额
  String get balance;

  // ==================== 额外信息 ====================

  TExtra? get extra;
}

/// Token 工厂接口 - 用于创建空对象
abstract interface class ITokenFactory<T extends IToken> {
  T createEmpty();
}
