import '../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

/// 根据 ID 获取示例用例
/// 
/// Usecase 封装了特定的业务逻辑，是应用层的业务操作单元
class FetchExampleById {
  final ExampleRepo _repository;

  /// 创建根据 ID 获取示例用例
  /// 
  /// [repository] 示例仓库实例
  FetchExampleById(this._repository);

  /// 执行根据 ID 获取示例操作
  /// 
  /// [id] 示例的唯一标识符
  /// 返回 [Result] 包含示例实体或错误信息
  Future<Result<ExampleEntity>> call(String id) async {
    return await _repository.fetchExampleById(id);
  }
}

