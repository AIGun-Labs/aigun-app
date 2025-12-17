import '../../../../infrastructure/network/dio_client.dart';
import '../models/native_token_model.dart';
import '../models/query_token_model.dart';

class TokenRemoteSource {
  TokenRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/wallet';
  static const String _intelPath = '/api/v1/intelligence';
  static const String _transferPath = '/api/v1/wallet_tx';

  Future<List<NativeTokenModel>> getNativeTokens() async {
    final response = await _dioClient.get('$_transferPath/native_token');

    final tokens = (response['tokens'] as List<dynamic>);

    return tokens.map((token) => NativeTokenModel.fromJson(token)).toList();
  }

  Future<List<QueryTokenModel>> getTokens(String keyword) async {
    final response = await _dioClient.get(
      '$_basePath/search',
      queryParameters: {'keyword': keyword},
    );

    return (response as List<dynamic>)
        .map((token) => QueryTokenModel.fromJson(token))
        .toList();
  }

  Future<List<QueryTokenModel>> searchTokens(
    String keyword,
    String? walletId,
  ) async {
    final response = await _dioClient.get(
      '$_intelPath/token/search',
      queryParameters: {'key_word': keyword, 'wallet_id': walletId},
    );

    return (response as List<dynamic>)
        .map((token) => QueryTokenModel.fromJson(token))
        .toList();
  }
}
