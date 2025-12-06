import '../../../../data/services/http/dio_client.dart';
import '../models/supported_chains_model.dart';

class ChainRemoteDataSource {
  final DioClient dioClient;

  ChainRemoteDataSource(this.dioClient);

  static const String _basePath = '/api/v1/wallet_tx';

  Future<SupportChainsModel> getSupportedChains() async {
    final response = await dioClient.get('$_basePath/chains');
    return SupportChainsModel.fromJson(response);
  }
}
