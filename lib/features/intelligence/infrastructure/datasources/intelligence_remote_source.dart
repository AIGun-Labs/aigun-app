import '../../../../core/enums/api_version.dart';
import '../../../../infrastructure/network/dio_client.dart';
import '../../../../utils/logger.dart';
import '../models/entity_model.dart';
import '../models/intelligence_model.dart';

/// Intelligence Remote Source
///
/// Handles HTTP API calls for intelligence data.
class IntelligenceRemoteSource {
  IntelligenceRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/intelligence';

  /// Fetch intelligence history
  ///
  /// [page] - Page number for pagination
  /// [type] - Type filter ('event' or 'radar_signal')
  /// [pageSize] - Number of items per page
  /// [chainSignal] - Chain filter for radar_signal type
  Future<List<IntelligenceModel>> fetchIntelligenceHistory({
    int? page,
    String? type,
    int? pageSize,
    String? chainSignal,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        if (page != null) 'page': page,
        if (type != null) 'type': type,
        if (pageSize != null) 'size': pageSize,
        if (chainSignal != null && chainSignal != 'all')
          'chain_signal': chainSignal,
        'is_valuable': true,
        'type': 'news',
      };

      final response = await _dioClient.get(
        _basePath,
        queryParameters: queryParameters,
        options: APIVersion.v2.options,
      );

      if (response == null) {
        return [];
      }

      // Handle both list and map responses
      if (response is List) {
        return response
            .map(
              (item) =>
                  IntelligenceModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }

      if (response is Map<String, dynamic>) {
        final data = response['data'];
        if (data is List) {
          return data
              .map(
                (item) =>
                    IntelligenceModel.fromJson(item as Map<String, dynamic>),
              )
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
      chainSignal: chainId,
    );
  }

  /// Fetch tokens by intelligence IDs
  ///
  /// Returns a map of intelligence ID to list of token models
  Future<Map<String, List<IntelligenceEntityModel>>>
  fetchTokensByIntelligenceIds(List<String> intelligenceIds) async {
    if (intelligenceIds.isEmpty) {
      return {};
    }

    try {
      // Join IDs with comma as per API requirement
      final intelligenceIdsString = intelligenceIds.join(',');

      final response = await _dioClient.get(
        '$_basePath/entities',
        queryParameters: {'intelligence_ids': intelligenceIdsString},
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
                .map(
                  (item) => IntelligenceEntityModel.fromJson(
                    item as Map<String, dynamic>,
                  ),
                )
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
