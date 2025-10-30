import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/data/models/index.dart';

class NetworkService {
  final DioClient _dioClient = getIt<DioClient>();
  static const String _basePath = '/api/v1/status';

  Future<NetworkResult> getServicesStatus() async {
    final response = await _dioClient.get(_basePath);

    if (response is Map<String, dynamic>) {
      final networkResult = NetworkResult.fromJson(response);
      return networkResult;
    }

    throw Exception('Invalid response data');
  }
}
