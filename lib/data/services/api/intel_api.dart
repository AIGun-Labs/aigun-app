import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:get_it/get_it.dart';

class IntelApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  static const String _basePath = "/api/v1/intelligence";

  Future<Map<String, List<Entity>>> getTokensByIntelIds(
      List<String> ids) async {
    final intelligenceIds = ids.join(',');

    final response = await _dioClient.get<Map<String, dynamic>>(
      '$_basePath/intelligence/entities',
      queryParameters: {
        'intelligence_ids': intelligenceIds,
      },
    );

    return response.map((key, value) => MapEntry(
          key,
          (value as List<dynamic>)
              .map((e) => Entity.fromJson(e as Map<String, dynamic>))
              .toList(),
        ));
  }

  /// get intelligences history api with page and pageSize
  Future<List<Intel>> getIntelsHistory(int? page, [int? pageSize]) async {
    final queryParameters = Map<String, dynamic>();
    if (page != null) {
      queryParameters['page'] = page;
    }
    if (pageSize != null) {
      queryParameters['size'] = pageSize;
    }

    final response =
        await _dioClient.get(_basePath, queryParameters: queryParameters);

    Logger.info(response.toString());

    // 如果响应直接是列表
    if (response is List) {
      return response
          .map((e) => Intel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
