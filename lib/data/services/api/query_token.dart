import '../../../core/service_locator.dart';
import '../../../utils/logger.dart';
import '../../models/token/query_token/query_token.dart';
import '../index.dart';

class QueryTokenApi {
  final DioClient dio = getIt<DioClient>();
  static const String _basePath = "/api/v1/intelligence";

  Future<List<QueryToken>> queryToken({
    required String keyWord,
    required String walletId,
    String? page,
    String? pageSize,
  }) async {
    final queryParameters = {
      "key_word": keyWord,
      "wallet_id": walletId.toString(),
    };

    if (page != null) {
      queryParameters["page"] = page.toString();
    }
    if (pageSize != null) {
      queryParameters["page_size"] = pageSize.toString();
    }

    final response = await dio.get("$_basePath/token/search",
        queryParameters: queryParameters);

    Logger.info(response.toString());

    return (response as List<dynamic>)
        .map((token) => QueryToken.fromJson(token))
        .toList();
  }
}
