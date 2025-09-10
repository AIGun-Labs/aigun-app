import 'package:flutter_aigun/data/models/wallet/native_token/native_token.dart';
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

    // final result = nativeTokens
    //     .map((token) => Token(
    //         chainId: token.chainId,
    //         chainLogo: token.chainLogo,
    //         chainName: token.chainName,
    //         tokenAvatar: token.logo ?? "",
    //         tokenName: token.name ?? "",
    //         address: "",
    //         tokenPrice: "",
    //         rawBalance: "",
    //         balance: "",
    //         decimals: token.decimals,
    //         symbol: token.chainType))
    //     .toList();

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

  Future<List<Token>> searchTokens(String keyword) async {
    final response =
        await dioClient.get("$_intelPath/search-tokens", queryParameters: {
      "key_word": keyword,
    });

    final tokens = (response as List<dynamic>)
        .map((token) => Token.fromJson(token))
        .toList();

    return tokens;
  }
}
