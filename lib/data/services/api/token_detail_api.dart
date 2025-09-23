import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/token_detail/security/security_state.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/logger.dart';

class TokenDetailApi {
  final DioClient _dioClient = getIt.call<DioClient>();

  static const String _basePath = '/api/v1/intelligence';

  Future<TokenDetailSecurity?> getTokenSecurity(
      String address, String chainName) async {
    final response =
        await _dioClient.get("$_basePath/token/security", queryParameters: {
      "address": address,
      "chain_name": chainName,
    });

    if (response == null) {
      return null;
    }
    // Logger.info("getTokenSecurity: $response");

    final tokenDetailSecurity = TokenDetailSecurity.fromJson(response);

    Logger.info("getTokenSecurity: $tokenDetailSecurity");
    return tokenDetailSecurity;
  }
}
