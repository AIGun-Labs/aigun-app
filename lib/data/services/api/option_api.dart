import '../../../infrastructure/network/dio_client.dart';
import '../../models/options/single_type/single_type.dart';

class OptionsApi {
  OptionsApi(this._dioClient);
  final DioClient _dioClient;
  static const String _basePath = '/api/v1/option';

  Future<List<SingleTypeOptions>> getSingleTypeOptions() async {
    final response = await _dioClient.get('$_basePath/signal-type');

    return (response as List<dynamic>)
        .map((e) => SingleTypeOptions.fromJson(e))
        .toList();
  }
}
