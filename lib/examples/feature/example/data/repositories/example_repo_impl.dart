import '../../../../../core/types/result.dart';
import '../../domain/entities/example_entity.dart';
import '../../domain/repositories/example_repo.dart';
import '../mappers/example_mapper.dart';
import '../sources/example_remote_source.dart';

/// 示例仓库实现
///
/// 实现 Domain Layer 定义的仓库接口
/// 负责协调数据源和映射器，将 Model 转换为 Entity
/// 处理异常并返回 Result 类型
class ExampleRepoImpl implements ExampleRepo {
  final ExampleRemoteSource _remoteSource;

  /// 创建示例仓库实现
  ///
  /// [remoteSource] 远程数据源实例
  ExampleRepoImpl(this._remoteSource);

  @override
  Future<Result<List<ExampleEntity>>> fetchExamples() async {
    try {
      final models = await _remoteSource.fetchExamples();
      final entities = models.map((model) => model.toEntity()).toList();
      return Result.success(entities);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<ExampleEntity>> fetchExampleById(String id) async {
    try {
      final model = await _remoteSource.fetchExampleById(id);
      return Result.success(model.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<ExampleEntity>> createExample({
    required String name,
    required String description,
  }) async {
    try {
      final model = await _remoteSource.createExample(
        name: name,
        description: description,
      );
      return Result.success(model.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
