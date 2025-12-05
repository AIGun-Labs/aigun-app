import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/intel/intel.dart';
import '../../../data/models/token/query_token/query_token.dart';
import '../../../data/models/token_detail/token/favorite_token.dart';
import '../../../utils/logger.dart';
import '../../../utils/validators/token_validator.dart';

part 'token.freezed.dart';
part 'token.g.dart';

// Static helper functions for JSON deserialization
Object? _readSlugOrNetwork(Map json, String key) {
  return json['slug'] ?? json['network'] ?? '';
}

Object? _readNetworkOrSlug(Map json, String key) {
  return json['network'] ?? json['slug'] ?? '';
}

@freezed
sealed class Token with _$Token {
  const Token._();

  const factory Token({
    @JsonKey(name: 'chain_id') required String chainId,
    // @JsonKey(name: "chain_name") String chainName,
    @JsonKey(name: 'chain_logo') required String chainLogo,
    @JsonKey(name: 'chain_name') required String chainName,
    @JsonKey(name: 'token_avatar') required String tokenAvatar,
    @JsonKey(name: 'token_name') required String tokenName,
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'token_price') required String tokenPrice,
    @JsonKey(name: 'raw_balance') required String rawBalance,
    @JsonKey(name: 'balance') required String balance,
    @JsonKey(name: 'decimals') required int decimals,
    @JsonKey(name: 'symbol') required String symbol,
    @JsonKey(name: 'slug', readValue: _readSlugOrNetwork)
    @Default('')
    String? slug,
    @JsonKey(name: 'price_change_24h') @Default(0) double? priceChange24h,
    @JsonKey(name: 'market_cap') @Default(0.0) double? marketCap,
    @JsonKey(name: 'network', readValue: _readNetworkOrSlug)
    @Default('')
    String? network,
    @JsonKey(name: 'is_native') required bool isNative,
  }) = _Token;

  String get unique {
    if (chainId.isEmpty || chainId == 'null') {
      return network ?? '';
    }
    return chainId;
  }

  static Token empty() => const Token(
    chainId: '',
    chainLogo: '',
    tokenAvatar: '',
    tokenName: '',
    address: '',
    decimals: 0,
    symbol: '',
    chainName: '',
    tokenPrice: '',
    rawBalance: '',
    balance: '',
    isNative: false,
  );

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  factory Token.fromQueryToken(QueryToken queryToken) {
    return Token(
      isNative: queryToken.isNative ?? false,
      chainId: queryToken.networkId.toString(),
      chainLogo: queryToken.networkLogo ?? '',
      chainName: queryToken.networkName ?? '',
      tokenAvatar: queryToken.logo ?? '',
      tokenName: queryToken.name ?? '',
      address: queryToken.address ?? '',
      tokenPrice: queryToken.priceUsd ?? '',
      rawBalance: queryToken.rawBalance ?? '',
      balance: queryToken.balance ?? '',
      decimals: queryToken.decimals ?? 0,
      network: queryToken.network ?? '',
      symbol: queryToken.symbol ?? '',
    );
  }

  factory Token.fromNativeTokenJson(Map<String, dynamic> json) {
    return Token(
      isNative: json['is_native'] ?? false,
      chainId: json['chain_id'],
      chainLogo: json['chain_logo'],
      chainName: json['chain_name'],
      tokenAvatar: json['token_avatar'],
      tokenName: json['token_name'],
      address: json['token_address'],
      tokenPrice: json['token_price'],
      rawBalance: json['raw_balance'],
      balance: json['balance'],
      decimals: json['decimals'],
      symbol: json['symbol'],
      slug: json['network'],
      network: json['network'],
    );
  }

  factory Token.fromEntity(Entity entity) {
    try {
      final token = Token(
        isNative: entity.isNative ?? entity.isNativeToken,
        chainId: entity.chain?.networkId ?? '',
        chainLogo: entity.chain?.logo ?? '',
        chainName: entity.chain?.name ?? '',
        tokenAvatar: entity.logo ?? '',
        tokenName: entity.name ?? '',
        address: entity.contractAddress ?? '',
        tokenPrice: '',
        rawBalance: '',
        balance: '',
        network: entity.chain?.slug ?? '',
        decimals: entity.decimals ?? 0,
        slug: entity.chain?.slug ?? '',
        symbol: entity.symbol ?? '',
      );
      return token;
    } catch (e) {
      Logger.error('Token.fromEntity : $e');
      return const Token(
        isNative: false,
        chainId: '',
        chainLogo: '',
        chainName: '',
        tokenAvatar: '',
        tokenName: '',
        address: '',
        tokenPrice: '',
        rawBalance: '',
        balance: '',
        decimals: 0,
        symbol: '',
      );
    }
  }

  factory Token.fromFavoriteToken(FavoriteToken favoriteToken) {
    return Token(
      isNative: false,
      chainId: '',
      chainLogo: favoriteToken.chainLogo,
      chainName: favoriteToken.chainName,
      tokenAvatar: favoriteToken.tokenAvatar,
      tokenName: favoriteToken.tokenName,
      address: favoriteToken.contractAddress,
      tokenPrice: favoriteToken.priceUsd,
      rawBalance: favoriteToken.rawBalance,
      balance: favoriteToken.balance,
      decimals: 0,
      slug: favoriteToken.network,
      symbol: favoriteToken.symbol,
      priceChange24h: double.tryParse(favoriteToken.priceChange24h) ?? 0,
      marketCap: double.tryParse(favoriteToken.marketCap) ?? 0.0,
      network: favoriteToken.network,
    );
  }

  // factory Token.fromHotTokenEntity(HotTokenEntity hotTokenEntity) {
  //   return Token(
  //     isNative: false,
  //     chainId: hotTokenEntity.chainIndex,
  //     chainLogo: hotTokenEntity.chainLogo,
  //     chainName: hotTokenEntity.chainName,
  //     tokenAvatar: hotTokenEntity.logo,
  //     tokenName: hotTokenEntity.name,
  //     address: hotTokenEntity.contractAddress,
  //     tokenPrice: hotTokenEntity.price,
  //     rawBalance: '',
  //     balance: '',
  //     decimals: int.parse(hotTokenEntity.decimals),
  //     symbol: hotTokenEntity.symbol,
  //     network: hotTokenEntity.network,
  //     slug: hotTokenEntity.slug,
  //     marketCap: double.tryParse(hotTokenEntity.marketCap) ?? 0.0,
  //   );
  // }

  // Convert Token to FavoriteToken
  FavoriteToken toFavoriteToken() {
    return FavoriteToken(
      network: network ?? '',
      contractAddress: address,
      tokenAvatar: tokenAvatar,
      priceChange24h: priceChange24h?.toString() ?? '',
      priceUsd: tokenPrice,
      chainLogo: chainLogo,
      chainName: chainName,
      tokenName: tokenName,
      balance: balance,
      rawBalance: rawBalance,
      balanceUsd: balance,
      symbol: symbol,
      marketCap: marketCap?.toString() ?? '',
    );
  }
}

extension TokenExtension on Token {
  bool get isNativeToken =>
      TokenValidator.isNativeToken(address, network: network ?? '');
}
