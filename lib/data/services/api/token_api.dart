import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TokenApi {
  final DioClient dioClient = GetIt.instance<DioClient>();

  static const String _basePath = '/api/v1/wallet';
  static const String _intelPath = "/api/v1/intelligence";
  static const String _transferPath = "/api/v1/wallet_tx";

  Future<List<Token>> getNativeTokens() async {
    final response = await dioClient.get("$_transferPath/native_token");

    return (response as List<dynamic>)
        .map((token) => Token.fromJson(token))
        .toList();
  }

  Future<List<Token>> getTokens(String keyword) async {
    final response = await dioClient.get("$_basePath/search", queryParameters: {
      "keyword": keyword,
    });

    final token = (response as List<dynamic>)
        .map((token) => Token.fromJson(token))
        .toList();

    return token;
  }

  Future<List<Token>> searchTokens(String keyword, String? walletId) async {
    final response =
        await dioClient.get("$_intelPath/token/search", queryParameters: {
      "key_word": keyword,
      "wallet_id": walletId,
    });

    final tokens = (response as List<dynamic>).map((token) {
      if (token['chain_id'].runtimeType == String) {
        Logger.info(token['chain_id']);
      }

      if (token['decimals'].runtimeType == String) {
        Logger.info(token['chain_id']);
      }

      return Token.fromJson(token);
    }).toList();

    return tokens;
  }
}
