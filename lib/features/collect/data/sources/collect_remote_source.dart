import '../../../../infrastructure/network/dio_client.dart';

class CollectRemoteSource {
  CollectRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/trade';

  static const String _collectTokensPath = '$_basePath/collected-tokens';

  static const String _pinPath = '$_basePath/top';

  String _ethereumToEth(String network) {
    return network == 'Ethereum' ? 'eth' : network;
  }

  Future<void> fetchAdd({
    required String network,
    required String address,
  }) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.post(
        _collectTokensPath,
        data: {'network': network, 'address': address},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchDelete({
    required String network,
    required String address,
  }) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.delete(
        _collectTokensPath,
        data: {'network': network, 'address': address},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchPin({
    required String network,
    required String address,
  }) async {
    try {
      network = _ethereumToEth(network);

      await _dioClient.post(
        _pinPath,
        data: {'network': network, 'address': address},
      );
    } catch (e) {
      rethrow;
    }
  }
}
