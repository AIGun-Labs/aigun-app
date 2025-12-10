import '../../../../data/services/http/dio_client.dart';
import '../models/list_token_model.dart';

class ListTokenRemoteSource {
  final DioClient _dioClient;
  ListTokenRemoteSource(this._dioClient);

  Future<List<ListTokenModel>> fetchTokens({
    required String apiUrl,
    String? lastTime,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (lastTime != null && lastTime.trim() != '') {
      queryParameters['last_query_time'] = lastTime;
    }

    try {
      final response = await _dioClient.get<List<dynamic>>(
        apiUrl,
        queryParameters: queryParameters,
      );
      return response.map((e) => ListTokenModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
