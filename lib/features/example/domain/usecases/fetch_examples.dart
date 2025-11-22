import '../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

/// 获取示例列表用例
/// 
/// Usecase 封装了特定的业务逻辑，是应用层的业务操作单元
/// 每个 Usecase 代表一个独立的业务功能
class FetchExamples {
  final ExampleRepo _repository;

  /// 创建获取示例列表用例
  /// 
  /// [repository] 示例仓库实例
  FetchExamples(this._repository);

  /// 执行获取示例列表操作
  /// 
  /// 返回 [Result] 包含示例实体列表或错误信息
  Future<Result<List<ExampleEntity>>> call() async {
    return await _repository.fetchExamples();
  }
}

