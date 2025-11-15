import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/services/index.dart';

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
