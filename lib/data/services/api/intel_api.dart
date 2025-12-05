import '../../../core/enums/api_version.dart';
import '../../models/intel/intel.dart';
import '../http/dio_client.dart';

class IntelApi {
  final DioClient _dioClient;
  IntelApi(this._dioClient);

  static const String _basePath = '/api/v1/intelligence';

  Future<Map<String, List<Entity>>> getTokensByIntelIds(
    List<String> ids,
  ) async {
    final intelligenceIds = ids.join(',');

    final response = await _dioClient.get<Map<String, dynamic>>(
      '$_basePath/entities',
      queryParameters: {'intelligence_ids': intelligenceIds},
    );

    final result = response.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>?)
                ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
    );

    return result;
  }

  /// get intelligences history api with page and pageSize

  Future<List<Intel>> getIntelsHistory(
    int? page, {
    String? type,
    int? pageSize,
    String? chainSingle,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageSize != null) {
      queryParameters['size'] = pageSize;
    }
    if (chainSingle != null && chainSingle != 'all') {
      queryParameters['chain_signal'] = chainSingle;
    }
    if (type != null) {
      queryParameters['type'] = type;
    }
    queryParameters['is_valuable'] = true;

    final options = APIVersion.v2.options;

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      options: options,
    );

    if (response is List) {
      return response
          .map((e) => Intel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
