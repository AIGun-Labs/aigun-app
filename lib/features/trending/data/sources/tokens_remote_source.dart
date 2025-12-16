import '../../../../infrastructure/network/dio_client.dart';
import '../../../../shared/data/models/trade_token_model.dart';
import '../models/realtime_request_model.dart';

class TokensRemoteSource {
  TokensRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/trade';

  static const String _tokensPath = '$_basePath/tokens';

  static const String _tokensRealtimePath = '$_basePath/tokens-realtime';

  Future<List<TradeTokenModel>> fetchTokens({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dioClient.get<List<dynamic>>(
      _tokensPath,
      queryParameters: queryParameters,
    );

    if (response == null) {
      throw Exception('Response is null');
    }

    return response.map((e) => TradeTokenModel.fromJson(e)).toList();
  }

  Future<List<TradeTokenModel>> fetchCollectedTokensByWalletId({
    required String walletId,
  }) async {
    final response = await _dioClient.get<List<dynamic>>(
      _tokensPath,
      queryParameters: {'wallet_id': walletId, 'type': 'tracking'},
    );

    if (response == null) {
      throw Exception('Response is null');
    }

    return response.map((e) => TradeTokenModel.fromJson(e)).toList();
  }

  Future<List<TradeTokenModel>> fetchTokensRealtime({
    required List<RealtimeRequestModel> body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dioClient.post<List<dynamic>>(
      _tokensRealtimePath,
      data: body.map((e) => e.toJson()).toList(),
      queryParameters: queryParameters,
    );

    if (response == null) {
      throw Exception('Response is null');
    }

    return response.map((e) => TradeTokenModel.fromJson(e)).toList();
  }
}
