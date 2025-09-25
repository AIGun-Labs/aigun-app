import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class FavoriteApi {
  static const String _basePath = "/api/v1/trade";

  final DioClient _dioClient = getIt<DioClient>();

  Future<List<Token>> getUserFavoriteToken() async {
    final response = await _dioClient.get("$_basePath/collected-tokens");

    return response.map((e) => Token.fromJson(e)).toList();
  }

  Future<void> addFavoriteToken({
    required String chainId,
    required String chainName,
    required String chainLogo,
    required String address,
    required String tokenName,
    required String symbol,
    required String tokenAvatar,
    required String decimals,
  }) async {
    final resposne =
        await _dioClient.post("$_basePath/collected-tokens", data: {
      "chain_id": chainId,
      "chain_name": chainName,
      "chain_logo": chainLogo,
      "address": address,
      "token_name": tokenName,
      "symbol": symbol,
      "token_avatar": tokenAvatar,
      "decimals": decimals,
    });

    Logger.info("response: $resposne");
  }

  Future<void> deleteFavoriteToken({
    required String chainName,
    required String address,
  }) async {
    await _dioClient.delete("$_basePath/collect-tokens", data: {
      "chain_name": chainName,
      "address": address,
    });
  }
}
