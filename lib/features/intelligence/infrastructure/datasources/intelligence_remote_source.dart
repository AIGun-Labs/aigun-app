import '../../../../data/services/http/dio_client.dart';
import '../../../../utils/logger.dart';
import '../models/intelligence_model.dart';
import '../models/entity_model.dart';

/// Intelligence Remote Source
///
/// Handles HTTP API calls for intelligence data.
class IntelligenceRemoteSource {
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/intelligence';

  IntelligenceRemoteSource(this._dioClient);

  /// Fetch intelligence history
  ///
  /// [page] - Page number for pagination
  /// [type] - Type filter ('event' or 'radar_signal')
  /// [pageSize] - Number of items per page
  /// [chainSingle] - Chain filter for radar_signal type
  Future<List<IntelligenceModel>> fetchIntelligenceHistory({
    int? page,
    String? type,
    int? pageSize,
    String? chainSingle,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) 'page': page,
        if (type != null) 'type': type,
        if (pageSize != null) 'page_size': pageSize,
        if (chainSingle != null && chainSingle != 'all')
          'chain_single': chainSingle,
      };

      final response = await _dioClient.get(
        _basePath,
        queryParameters: queryParameters,
      );

      if (response == null) {
        return [];
      }

      // Handle both list and map responses
      if (response is List) {
        return response
            .map((item) =>
                IntelligenceModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      if (response is Map<String, dynamic>) {
        final data = response['data'];
        if (data is List) {
          return data
              .map((item) =>
                  IntelligenceModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e, s) {
      Logger.error('fetchIntelligenceHistory error: $e\n$s');
      rethrow;
    }
  }

  /// Fetch event-type intelligence
  Future<List<IntelligenceModel>> fetchEventIntelligence({
    int? page,
    int? pageSize,
  }) {
    return fetchIntelligenceHistory(
      page: page,
      type: 'event',
      pageSize: pageSize,
    );
  }

  /// Fetch signal-type intelligence
  Future<List<IntelligenceModel>> fetchSignalIntelligence({
    required String chainId,
    int? page,
    int? pageSize,
  }) {
    return fetchIntelligenceHistory(
      page: page,
      type: 'radar_signal',
      pageSize: pageSize,
      chainSingle: chainId,
    );
  }

  /// Fetch tokens by intelligence IDs
  ///
  /// Returns a map of intelligence ID to list of token models
  Future<Map<String, List<IntelligenceEntityModel>>> fetchTokensByIntelligenceIds(
    List<String> intelligenceIds,
  ) async {
    if (intelligenceIds.isEmpty) {
      return {};
    }

    try {
      final response = await _dioClient.post(
        '$_basePath/tokens',
        data: {'ids': intelligenceIds},
      );

      if (response == null) {
        return {};
      }

      final Map<String, List<IntelligenceEntityModel>> result = {};

      if (response is Map<String, dynamic>) {
        for (final entry in response.entries) {
          final key = entry.key;
          final value = entry.value;

          if (value is List) {
            result[key] = value
                .map((item) => IntelligenceEntityModel.fromJson(
                    item as Map<String, dynamic>))
                .toList();
          }
        }
      }

      return result;
    } catch (e, s) {
      Logger.error('fetchTokensByIntelligenceIds error: $e\n$s');
      rethrow;
    }
  }
}
