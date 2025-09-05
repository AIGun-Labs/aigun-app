import 'package:flutter_aigun/data/models/wallet/native_token/native_token.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

class TokenApi {
  final DioClient dioClient = GetIt.instance<DioClient>();

  static const String _basePath = '/api/v1/wallet';

  Future<List<Token>> getNativeTokens() async {
    final response = await dioClient.get("$_basePath/native_token");
    // final nativeTokens = (response as List<dynamic>)
    //     .map((token) => NativeToken.fromJson(token))
    //     .toList();

    // return nativeTokens;
    print("Response: $response");

    final nativeTokens = (response as List<dynamic>)
        .map((token) => NativeToken.fromJson(token))
        .toList();

    print("Response: $nativeTokens");

    final result = nativeTokens
        .map((token) => Token(
            chainId: token.chainId,
            chainLogo: token.chainLogo,
            chainName: token.chainName,
            tokenAvatar: token.logo ?? "",
            tokenName: token.name ?? "",
            address: "",
            tokenPrice: "",
            rawBalance: "",
            balance: "",
            decimals: token.decimals,
            symbol: token.chainType))
        .toList();

    return result;
  }
}
