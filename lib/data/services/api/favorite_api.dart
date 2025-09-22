import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class FavoriteApi {
  static const String _basePath = "/api/v1/trade";

  final DioClient _dioClient = getIt<DioClient>();

  Future<List<Token>> getUserFavoriteToken() async {
    final response = await _dioClient.get("$_basePath/collected-tokens");

    return response.map((e) => Token.fromJson(e)).toList();
  }

  Future<void> addFavoriteToken(Token token) async {
    await _dioClient.post("$_basePath/collect-tokens", data: {
      "chain_id": token.chainId,
      "chain_name": token.chainName,
      "chain_logo": token.chainLogo,
      "address": token.address,
      "token_name": token.tokenName,
      "symbol": token.symbol,
      "token_avatar": token.tokenAvatar,
      "decimals": token.decimals,
    });
  }

  Future<void> unFavoriteToken({
    required String chainName,
    required String address,
  }) async {
    await _dioClient.delete("$_basePath/uncollect-tokens", data: {
      "chain_name": chainName,
      "address": address,
    });
  }
}
