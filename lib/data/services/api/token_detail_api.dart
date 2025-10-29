import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/logger.dart';

class TokenDetailApi {
  final DioClient _dioClient = getIt<DioClient>();

  static const String _basePath = '/api/v1/intelligence';
  static const String _basePathV2 = '/api/v1/intelligence/';

  Future<TokenDetailSecurity?> getTokenSecurity(
      String address, String network) async {
    final response =
        await _dioClient.get("$_basePath/token/security", queryParameters: {
      "address": address,
      "network": network,
    });

    if (response == null) {
      return null;
    }

    // Logger.info("getTokenSecurity: $response");

    final tokenDetailSecurity = TokenDetailSecurity.fromJson(response);

    Logger.info("getTokenSecurity: $tokenDetailSecurity");
    return tokenDetailSecurity;
  }

  Future<TokenDetailInfo?> getTokenDetailInfo(String address, String network,
      {String? type}) async {
    final queryParameters = <String, dynamic>{
      "address": address,
      "network": network.toLowerCase(),
    };

    if (type != null) {
      queryParameters['type'] = type;
    }

    final tokenDetailInfo = await _dioClient.get("$_basePath/token/info",
        queryParameters: queryParameters);

    if (tokenDetailInfo == null) {
      return null;
    }

    return TokenDetailInfo.fromJson(tokenDetailInfo);
  }

  Future<List<Intel>> getTokenAssociatedIntels(
      String address, String chainName, int? page, int? pageSize) async {
    if (chainName.toLowerCase() == "ethereum") {
      chainName = "eth";
    }

    final queryParameters = <String, dynamic>{};

    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageSize != null) {
      queryParameters['size'] = pageSize;
    }

    queryParameters['chain_name'] = chainName;
    queryParameters['address'] = address;
    queryParameters['is_valuable'] = "1";

    final response =
        await _dioClient.get(_basePathV2, queryParameters: queryParameters);

    if (response is List) {
      return response.map((e) => Intel.fromJson(e)).toList();
    }

    return [];
  }

  Future<TokenDetailUrls?> getTokenDetailUrls(
      String address, String chainName, String tokenName) async {
    final response =
        await _dioClient.get("$_basePath/token/urls", queryParameters: {
      "address": address,
      "chain_name": chainName.toLowerCase(),
      "token_name": tokenName.toLowerCase(),
    });
    Logger.info("getTokenDetailUrls: $response");

    final tokenDetailUrls = TokenDetailUrls.fromJson(response);

    return tokenDetailUrls;
  }

  Future<int> getTokenIntelCount(String address, String network) async {
    final response =
        await _dioClient.get("$_basePath/token/count", queryParameters: {
      "address": address,
      "network": network,
    });

    return response ?? 0;
  }
}
