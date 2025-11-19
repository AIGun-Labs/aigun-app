import '../../../../data/services/http/dio_client.dart';
import '../models/collect_token_model.dart';

class CollectRemoteSource {
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/trade';

  static const String _collectTokensPath = '$_basePath/collected-tokens';

  static const String _pinPath = '$_basePath/top';

  CollectRemoteSource(this._dioClient);

  String _ethereumToEth(String network) {
    return network == 'Ethereum' ? 'eth' : network;
  }

  /// 获取收藏的代币列表
  Future<List<CollectTokenModel>> fetchCollectTokens(
      {required String walletId}) async {
    try {
      final res = await _dioClient.get(_collectTokensPath, queryParameters: {
        'wallet_id': walletId,
      });

      if (res is List<dynamic>) {
        return res.map((e) => CollectTokenModel.fromJson(e)).toList();
      }

      throw Exception('Invalid response');
    } catch (e) {
      rethrow;
    }
  }

  /// 添加收藏的代币
  Future<void> fetchAdd(
      {required String network, required String address}) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.post(_collectTokensPath, data: {
        'network': network,
        'address': address,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 删除收藏的代币
  Future<void> fetchDelete(
      {required String network, required String address}) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.delete(_collectTokensPath, data: {
        'network': network,
        'address': address,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// 置顶收藏的代币
  Future<void> fetchPin(
      {required String network, required String address}) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.post(_pinPath, data: {
        'network': network,
        'address': address,
      });
    } catch (e) {
      rethrow;
    }
  }
}
