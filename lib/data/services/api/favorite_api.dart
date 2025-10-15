import 'package:flutter_aigun/data/models/token_detail/token/favorite_token.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/utils/logger.dart';

import '../../../core/service_locator.dart';

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

    Logger.info("getUserFavoriteToken: $response");

    // final tokens = response.map((e) => FavoriteToken.fromJson(e)).toList();
    final List<FavoriteToken> tokens = (response as List<dynamic>)
        .map<FavoriteToken>(
            (e) => FavoriteToken.fromJson(e as Map<String, dynamic>))
        .toList();

    return tokens;
  }

  Future<void> addFavoriteToken({
    required String network,
    required String address,
  }) async {
    if (network == 'ethereum') {
      network = 'eth';
    }

    await _dioClient.post("$_basePath/collected-tokens", data: {
      "network": network,
      "address": address,
    });
  }

  Future<void> deleteFavoriteToken({
    required String network,
    required String address,
  }) async {
    if (network == 'Ethereum') {
      network = 'eth';
    }

    await _dioClient.delete("$_basePath/collected-tokens", data: {
      "network": network,
      "address": address,
    });
  }

  Future<void> pinFavoriteToken({
    required String network,
    required String address,
  }) async {
    await _dioClient.post("$_basePath/top", data: {
      "network": network,
      "address": address,
    });
  }
}
