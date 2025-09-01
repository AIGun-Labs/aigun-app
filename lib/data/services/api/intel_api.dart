import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:get_it/get_it.dart';

class IntelApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  static const String _basePath = "/api/v1/intelligence";

  Future<List<Entity>> getTokensByIntelIds(List<String> ids) async {
    final intelligenceIds = ids.join(',');

    final response = await _dioClient.get<Map<String, dynamic>>(
      '$_basePath/intelligence/entities',
      queryParameters: {
        'intelligence_ids': intelligenceIds,
      },
    );
    return (response as List).map((e) => Entity.fromJson(e)).toList();
  }
}
