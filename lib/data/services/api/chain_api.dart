import 'package:get_it/get_it.dart';

import '../../models/index.dart';
import '../index.dart';

class ChainApi {
  static const String _basePath = '/api/v1/wallet';
  final DioClient dioClient = GetIt.instance<DioClient>();

  Future<List<Chain>> getChains() async {
    final response = await dioClient.get(
      "$_basePath/chains",
    );

    final chains = response['chains'] as List<dynamic>;

    if (chains.isEmpty) {
      return [];
    }

    return chains.map((chain) => Chain.fromJson(chain)).toList();
  }

  /// 获取链
  Future<List<Chain>> getChain() async {
    final response = await dioClient.get('$_basePath/chains');

    // 响应拦截器已自动提取data字段，直接使用response.data
    final chainsData = response;
    final chains = chainsData
        .map((chain) => Chain.fromJson(chain as Map<String, dynamic>))
        .toList();
    return chains;
  }

  /// 链类型
  Future<Map<String, dynamic>> getChainType() async {
    final response = await dioClient.get(
      '$_basePath/chain-types',
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return response;
  }

  /// 指定类型的链
  Future<Map<String, dynamic>> getChainByType(String chainType) async {
    final response = await dioClient.get(
      '$_basePath/chains/$chainType',
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return response;
  }
}
