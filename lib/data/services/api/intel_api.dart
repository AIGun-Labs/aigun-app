import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:get_it/get_it.dart';

class IntelApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  static const String _basePath = "/api/v1/intelligence";

  Future<Map<String, List<Entity>>> getTokensByIntelIds(
      List<String> ids) async {
    final intelligenceIds = ids.join(',');

    final response = await _dioClient.get<Map<String, dynamic>>(
      '$_basePath/entities',
      queryParameters: {
        'intelligence_ids': intelligenceIds,
      },
    );

    final result = response.map((key, value) => MapEntry(
          key,
          (value as List<dynamic>?)
                  ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ));

    return result;
  }

  /// get intelligences history api with page and pageSize
  Future<List<Intel>> getIntelsHistory(int? page, [int? pageSize]) async {
    final queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageSize != null) {
      queryParameters['size'] = pageSize;
    }

// TODO： 先固定只获取有价值的情报
    queryParameters['is_valuable'] = "1";

    final response =
        await _dioClient.get(_basePath, queryParameters: queryParameters);

    // 如果响应直接是列表
    if (response is List) {
      return response
          .map((e) => Intel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
