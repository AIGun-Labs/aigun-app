import '../../../../infrastructure/network/dio_client.dart';
import '../models/claim_token_model.dart';

class ClaimTokenRemoteSource {
  ClaimTokenRemoteSource(this._dioClient);
  final DioClient _dioClient;
  static const String _basePath = '/api/v1/invite';

  static const String _tokensPath = '$_basePath/tokens/unclaimed';

  static const String _claimTokenPath = '$_basePath/token/claim';
  Future<List<ClaimTokenModel>> fetchUnclaimedTokens() async {
    try {
      final data = await _dioClient.get(_tokensPath);
      return (data as List<dynamic>)
          .map((e) => ClaimTokenModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> fetchClaimToken(
    String network,
    String contractAddress,
    String amount,
  ) async {
    try {
      await _dioClient.post(
        _claimTokenPath,
        data: {
          'network': network,
          'contract_address': contractAddress,
          'amount': amount,
        },
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
