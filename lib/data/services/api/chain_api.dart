import '../../../infrastructure/network/dio_client.dart';
import '../../models/index.dart';

class ChainApi {
  ChainApi(this._dioClient);
  static const String _basePath = '/api/v1/wallet';
  final DioClient _dioClient;

  Future<List<Chain>> getChains() async {
    final response = await _dioClient.get('$_basePath/chains');

    final chains = response['chains'] as List<dynamic>;

    if (chains.isEmpty) {
      return [];
    }

    return chains.map((chain) => Chain.fromJson(chain)).toList();
  }

  Future<List<Chain>> getChain() async {
    final response = await _dioClient.get('$_basePath/chains');
    final chainsData = response;
    final chains = chainsData
        .map((chain) => Chain.fromJson(chain as Map<String, dynamic>))
        .toList();
    return chains;
  }

  Future<Map<String, dynamic>> getChainType() async {
    final response = await _dioClient.get('$_basePath/chain-types');
    return response;
  }

  Future<Map<String, dynamic>> getChainByType(String chainType) async {
    final response = await _dioClient.get('$_basePath/chains/$chainType');
    return response;
  }
}
