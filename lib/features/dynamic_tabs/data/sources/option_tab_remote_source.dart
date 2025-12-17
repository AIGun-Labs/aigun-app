import '../../../../infrastructure/network/dio_client.dart';
import '../models/option_tab_model.dart';

class OptionTabRemoteSource {
  OptionTabRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/option';

  static const String _optionTabPath = '$_basePath/tab';

  Future<OptionTabModel> getOptionTab() async {
    final response = await _dioClient.get(_optionTabPath);
    return OptionTabModel.fromJson(response);
  }
}
