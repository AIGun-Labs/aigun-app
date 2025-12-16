import '../../../../infrastructure/network/dio_client.dart';
import '../models/supported_chains_model.dart';

class ChainRemoteDataSource {
  ChainRemoteDataSource(this.dioClient);
  final DioClient dioClient;

  static const String _basePath = '/api/v1/wallet_tx';

  Future<SupportChainsModel> getSupportedChains() async {
    final response = await dioClient.get('$_basePath/supported_chains');
    return SupportChainsModel.fromJson(response);
  }
}
