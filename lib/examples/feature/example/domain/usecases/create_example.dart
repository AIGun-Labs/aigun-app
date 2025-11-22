import '../../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

/// 创建示例用例
///
/// Usecase 封装了特定的业务逻辑，是应用层的业务操作单元
class CreateExample {
  final ExampleRepo _repository;

  /// 创建创建示例用例
  ///
  /// [repository] 示例仓库实例
  CreateExample(this._repository);

  /// 执行创建示例操作
  ///
  /// [name] 名称
  /// [description] 描述信息
  /// 返回 [Result] 包含创建的示例实体或错误信息
  Future<Result<ExampleEntity>> call({
    required String name,
    required String description,
  }) async {
    return await _repository.createExample(
      name: name,
      description: description,
    );
  }
}
