import '../../../utils/logger.dart';
import '../../../widgets/token/models/token.dart';
import '../index.dart';

class TokenApi {
  final DioClient _dioClient;
  TokenApi(this._dioClient);

  static const String _basePath = '/api/v1/wallet';
  static const String _intelPath = '/api/v1/intelligence';
  static const String _transferPath = '/api/v1/wallet_tx';

  Future<List<Token>> getNativeTokens() async {
    final response = await _dioClient.get('$_transferPath/native_token');

    final tokens = (response['tokens'] as List<dynamic>);

    return tokens.map((token) => Token.fromNativeTokenJson(token)).toList();
  }

  Future<List<Token>> getTokens(String keyword) async {
    final response =
        await _dioClient.get('$_basePath/search', queryParameters: {
      'keyword': keyword,
    });

    final token = (response as List<dynamic>)
        .map((token) => Token.fromJson(token))
        .toList();

    return token;
  }

  Future<List<Token>> searchTokens(String keyword, String? walletId) async {
    final response =
        await _dioClient.get('$_intelPath/token/search', queryParameters: {
      'key_word': keyword,
      'wallet_id': walletId,
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
