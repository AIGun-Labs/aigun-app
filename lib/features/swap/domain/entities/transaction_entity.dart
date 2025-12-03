import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

/// 交易代币实体 - 纯业务模型
/// 注意: 历史原因命名为 TransactionEntity，实际表示 SwapToken
@freezed
sealed class TransactionEntity with _$TransactionEntity {
  const TransactionEntity._();

  const factory TransactionEntity({
    required String chainId,
    required String chainLogo,
    required String chainName,
    required String tokenAvatar,
    required String tokenName,
    required String address,
    required int decimals,
    required String symbol,
    required double tokenPrice,
    required bool isNative,
    String? balance,
    String? network,
  }) = _TransactionEntity;

  /// 唯一标识符
  String get uniqueId {
    if (chainId.isEmpty || chainId == 'null') {
      return network ?? '';
    }
    return chainId;
  }

  /// 是否有余额
  bool get hasBalance =>
      balance != null &&
      balance!.isNotEmpty &&
      (double.tryParse(balance!) ?? 0) > 0;

  /// 默认 SOL 代币
  static const TransactionEntity defaultSol = TransactionEntity(
    isNative: true,
    chainId: '1151111081099710',
    chainLogo: 'https://cdn.idogex.ai/assets/chain/sol.png',
    chainName: 'Solana',
    tokenAvatar:
        'https://cdn.idogex.ai/image/HGQ_T4YvqPvIpIi-mvX06fwQfHrEDjIJd_IIPq2Q9qpZRPNil0mkN1fkeZgyKGKXQOMcrrPzTUxtGK-Q9rK1Ow==',
    tokenName: 'SOL',
    address: '11111111111111111111111111111111',
    tokenPrice: 0,
    balance: '0',
    decimals: 9,
    network: 'solana',
    symbol: 'SOL',
  );

  /// 默认 USDC 代币
  static const TransactionEntity defaultUsdc = TransactionEntity(
    isNative: false,
    chainId: '1151111081099710',
    chainLogo: 'https://cdn.idogex.ai/assets/chain/sol.png',
    chainName: 'Solana',
    tokenAvatar:
        'https://cdn.idogex.ai/image/1f0a8217-21c3-6036-8926-dc85371428bf.png',
    tokenName: 'USDC',
    address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
    tokenPrice: 0,
    balance: '0',
    decimals: 6,
    network: 'solana',
    symbol: 'USDC',
  );

  /// 空实体
  static const TransactionEntity empty = TransactionEntity(
    chainId: '',
    chainLogo: '',
    chainName: '',
    tokenAvatar: '',
    tokenName: '',
    address: '',
    decimals: 0,
    symbol: '',
    tokenPrice: 0,
    isNative: false,
  );
}
