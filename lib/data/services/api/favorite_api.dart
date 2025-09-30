import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';

class FavoriteApi {
  static const String _basePath = "/api/v1/trade";

  final DioClient _dioClient = getIt<DioClient>();

  Future<List<FavoriteToken>> getUserFavoriteToken({
    required String walletId,
  }) async {
    final response =
        await _dioClient.get("$_basePath/collected-tokens", queryParameters: {
      "wallet_id": walletId,
    });

    // final tokens = response.map((e) => FavoriteToken.fromJson(e)).toList();
    final List<FavoriteToken> tokens = (response as List<dynamic>)
        .map<FavoriteToken>(
            (e) => FavoriteToken.fromJson(e as Map<String, dynamic>))
        .toList();

    return tokens;
  }

  Future<void> addFavoriteToken({
    required String chainId,
    required String network,
    required String chainLogo,
    required String address,
    required String tokenName,
    required String symbol,
    required String tokenAvatar,
    required String decimals,
  }) async {
    await _dioClient.post("$_basePath/collected-tokens", data: {
      "chain_id": chainId,
      "network": network,
      "chain_logo": chainLogo,
      "address": address,
      "token_name": tokenName,
      "symbol": symbol,
      "token_avatar": tokenAvatar,
      "decimals": decimals,
    });
  }

  Future<void> deleteFavoriteToken({
    required String chainName,
    required String address,
  }) async {
    await _dioClient.delete("$_basePath/collected-tokens", data: {
      "chain_name": chainName,
      "address": address,
    });
  }
}
