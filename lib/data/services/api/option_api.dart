import '../../models/options/single_type/single_type.dart';
import '../http/dio_client.dart';

class OptionsApi {
  final DioClient _dioClient;
  OptionsApi(this._dioClient);
  static const String _basePath = '/api/v1/option';

  Future<List<SingleTypeOptions>> getSingleTypeOptions() async {
    final response = await _dioClient.get('$_basePath/signal-type');

    return (response as List<dynamic>)
        .map((e) => SingleTypeOptions.fromJson(e))
        .toList();
  }
}
