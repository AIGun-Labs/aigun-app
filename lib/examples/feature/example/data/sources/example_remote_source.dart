import '../../../../../infrastructure/network/dio_client.dart';
import '../models/example_model.dart';

/// 示例远程数据源
///
/// 负责与后端 API 进行通信，处理网络请求
/// 只负责数据获取，不包含业务逻辑
class ExampleRemoteSource {
  /// 创建示例远程数据源
  ///
  /// [dioClient] HTTP 客户端实例
  ExampleRemoteSource(this._dioClient);
  final DioClient _dioClient;

  /// API 基础路径
  static const String _basePath = '/api/v1/example';

  /// 获取示例列表的 API 路径
  static const String _examplesPath = '$_basePath/list';

  /// 根据 ID 获取示例的 API 路径
  static String exampleByIdPath(String id) => '$_basePath/$id';

  /// 创建示例的 API 路径
  static const String _createExamplePath = '$_basePath/create';

  /// 获取示例数据列表
  ///
  /// 从服务器获取所有示例数据
  /// 返回示例模型列表
  /// 抛出异常如果请求失败
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

  /// 根据 ID 获取单个示例数据
  ///
  /// [id] 示例的唯一标识符
  /// 返回示例模型实例
  /// 抛出异常如果请求失败
  Future<ExampleModel> fetchExampleById(String id) async {
    try {
      final data = await _dioClient.get(exampleByIdPath(id));
      return ExampleModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// 创建新的示例数据
  ///
  /// [name] 名称
  /// [description] 描述信息
  /// 返回创建的示例模型实例
  /// 抛出异常如果请求失败
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
