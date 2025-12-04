import '../../../../core/enums/api_version.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../data/services/http/dio_client.dart';
import '../../../../shared/data/models/intel_v2_model.dart';
import '../models/detail_info_model.dart';
import '../models/token_profit_model.dart';
import '../models/token_security_model.dart';
import '../models/urls_model.dart';

class TokenDetailRemoteSource {
  final DioClient _dioClient;
  TokenDetailRemoteSource(this._dioClient);

  static const String _basePath = '/api/v1/intelligence';

  static const String _detailInfoPath = '$_basePath/token/info';

  static const String _tokenSecurityPath = '$_basePath/token/security';

  static const String _urlsPath = '$_basePath/token/urls';

  static const String _intelCountPath = '$_basePath/token/count';

  static const String _tokenProfitPath = '$_basePath/token/profit';

  Future<DetailInfoModel> getDetailInfo({
    required String address,
    required String network,
    String? type,
  }) async {
    final queryParameters = <String, dynamic>{
      'address': address,
      'network': network,
    };

    if (type != null) {
      queryParameters['token_type'] = type;
    }

    final tokenDetailInfo = await _dioClient.get(
      _detailInfoPath,
      queryParameters: queryParameters,
    );

    return DetailInfoModel.fromJson(tokenDetailInfo);
  }

  Future<TokenSecurityModel> getTokenSecurity({
    required String address,
    required String network,
  }) async {
    final tokenSecurity = await _dioClient.get(
      _tokenSecurityPath,
      queryParameters: {'address': address, 'network': network},
    );

    return TokenSecurityModel.fromJson(tokenSecurity);
  }

  Future<List<Intel>> getTokenAssociatedIntels(
    String address,
    String network,
    int? page,
    int? pageSize,
  ) async {
    final queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageSize != null) {
      queryParameters['size'] = pageSize;
    }

    queryParameters['network'] = network;
    queryParameters['address'] = address;
    // queryParameters['is_valuable'] = "1";

    final options = APIVersion.v2.options;

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      options: options,
    );

    if (response is List) {
      return response.map((e) => Intel.fromJson(e)).toList();
    }

    return [];
  }

  Future<UrlsModel> getUrls({
    required String address,
    required String network,
  }) async {
    final tokenUrls = await _dioClient.get(
      _urlsPath,
      queryParameters: {'address': address, 'network': network},
    );

    return UrlsModel.fromJson(tokenUrls);
  }

  Future<int> getIntelCount({
    required String address,
    required String network,
  }) async {
    final response = await _dioClient.get(
      _intelCountPath,
      queryParameters: {'address': address, 'network': network},
    );

    return response ?? 0;
  }

  Future<IntelV2Model> getLatestIntelV2({
    required String address,
    required String network,
  }) async {
    final res = await _dioClient.get<List<dynamic>>(
      _basePath,
      queryParameters: {
        'address': address,
        'network': network,
        'page': 1,
        'size': 1,
      },
      options: APIVersion.v2.options,
    );

    final result = res.map((e) => IntelV2Model.fromJson(e)).toList();
    return result.first;
  }

  Future<TokenProfitModel> getTokenProfit({
    required String walletId,
    required String address,
    required String network,
  }) async {
    final response = await _dioClient.get(
      _tokenProfitPath,
      queryParameters: {
        'address': address,
        'network': network,
        'wallet_id': walletId,
      },
    );
    return TokenProfitModel.fromJson(response);
  }
}
