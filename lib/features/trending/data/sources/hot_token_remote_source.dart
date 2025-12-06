import '../../../../data/services/http/dio_client.dart';
import '../models/hot_token_model.dart';
import '../models/networks_model.dart';


/// 热门代币远程数据源
class HotTokenRemoteSource {
  final DioClient _dioClient;

  HotTokenRemoteSource(this._dioClient);

  static const String _basePath = '/api/v1/trade';
  static const String _topTokensEndpoint = '$_basePath/top-tokens';
  static const String _networksEndpoint = '$_basePath/top-tokens-networks';

  /// 获取热门代币列表
  Future<List<HotTokenModel>> fetchHotTokens(String? network) async {
    try {
      final queryParameters = <String, dynamic>{
        'network': network ?? 'all',
      };

      final data = await _dioClient.get(
        _topTokensEndpoint,
        queryParameters: queryParameters,
      );

      if (data != null && data.isNotEmpty) {
        final tokensModel =
            HotTokensModel.fromJson(data as Map<String, dynamic>);

        return tokensModel.tokens
            .map((token) => HotTokenModel.fromJson(token.toJson()))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  /// 获取支持的网络列表
  Future<NetworksModel> fetchNetworks() async {
    try {
      final data = await _dioClient.get(_networksEndpoint);

      if (data != null && data.isNotEmpty) {
        return NetworksModel.fromJson(data);
      }
      return NetworksModel.fromJson({});
    } catch (e) {
      rethrow;
    }
  }
}
