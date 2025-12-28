import '../../../../data/models/intel/intel.dart';
import '../../../../data/models/token/query_token/query_token.dart';
import '../../../../widgets/token/models/token.dart';
import '../../domain/entities/transaction_entity.dart';

extension TokenToTransactionEntity on Token {
  TransactionEntity toTransactionToken() {
    return TransactionEntity(
      isNative: isNativeToken,
      chainId: chainId,
      chainLogo: chainLogo,
      tokenAvatar: tokenAvatar,
      tokenName: tokenName,
      address: address,
      decimals: decimals,
      symbol: symbol,
      chainName: chainName,
      network: network,
      tokenPrice: double.tryParse(tokenPrice) ?? 0,
      balance: balance,
    );
  }
}

extension TransactionTokenMapper on TransactionEntity {
  TransactionEntity fromToken(Token token) {
    return TransactionEntity(
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

  TransactionEntity fromIntelEntity(Entity entity) {
    return TransactionEntity(
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
  }

  TransactionEntity fromQueryToken(QueryToken token) {
    return TransactionEntity(
      isNative: token.isNative ?? false,
      chainId: token.networkId?.toString() ?? '',
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

  TransactionEntity fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      isNative: json['is_native'] ?? json['is_navtive'] ?? false,
      chainId: json['chain_id'] ?? '',
      chainLogo: json['chain_logo'] ?? '',
      tokenAvatar: json['token_avatar'] ?? '',
      tokenName: json['token_name'] ?? '',
      address: json['address'] ?? '',
      decimals: json['decimals'] ?? 0,
      symbol: json['symbol'] ?? '',
      chainName: json['chain_name'] ?? '',
      network: json['network'] ?? '',
      tokenPrice: (json['token_price'] as num?)?.toDouble() ?? 0,
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson(TransactionEntity entity) {
    return {
      'is_native': entity.isNative,
      'chain_id': entity.chainId,
      'chain_logo': entity.chainLogo,
      'token_avatar': entity.tokenAvatar,
      'token_name': entity.tokenName,
      'address': entity.address,
      'decimals': entity.decimals,
      'symbol': entity.symbol,
      'chain_name': entity.chainName,
      'network': entity.network,
      'token_price': entity.tokenPrice,
      'balance': entity.balance,
    };
  }

  List<TransactionEntity> fromTokenList(List<Token> tokens) {
    return tokens.map(fromToken).toList();
  }

  List<TransactionEntity> fromQueryTokenList(List<QueryToken> tokens) {
    return tokens.map(fromQueryToken).toList();
  }

  Token toToken() {
    return Token(
      chainId: chainId,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenAvatar: tokenAvatar,
      tokenName: tokenName,
      address: address,
      tokenPrice: tokenPrice.toString(),
      rawBalance: '',
      balance: balance.toString(),
      decimals: decimals,
      symbol: symbol,
      isNative: isNative,
      network: network ?? '',
      slug: network ?? '',
    );
  }
}
