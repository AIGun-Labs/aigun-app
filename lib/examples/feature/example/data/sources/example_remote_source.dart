import '../../../../../data/services/http/dio_client.dart';
import '../models/example_model.dart';

///

class ExampleRemoteSource {
  final DioClient _dioClient;

  ///

  ExampleRemoteSource(this._dioClient);

  static const String _basePath = '/api/v1/example';

  static const String _examplesPath = '$_basePath/list';

  static String exampleByIdPath(String id) => '$_basePath/$id';

  static const String _createExamplePath = '$_basePath/create';

  ///

  Future<List<ExampleModel>> fetchExamples() async {
    try {
      final data = await _dioClient.get(_examplesPath);
      return (data as List<dynamic>)
          .map((e) => ExampleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  ///

  Future<ExampleModel> fetchExampleById(String id) async {
    try {
      final data = await _dioClient.get(exampleByIdPath(id));
      return ExampleModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  ///

  Future<ExampleModel> createExample({
    required String name,
    required String description,
  }) async {
    try {
      final data = await _dioClient.post(
        _createExamplePath,
        data: {'name': name, 'description': description},
      );
      return ExampleModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
