import '../../../../core/types/result.dart';
import '../entities/example_entity.dart';

/// 示例功能仓库接口
///
/// 定义数据访问的抽象接口，由 Data Layer 实现
/// 遵循依赖倒置原则，Domain Layer 不依赖 Data Layer
abstract class ExampleRepo {
  /// 获取示例数据列表
  ///
  /// 返回 [Result] 包含示例实体列表或错误信息
  Future<Result<List<ExampleEntity>>> fetchExamples();

  /// 根据 ID 获取单个示例数据
  ///
  /// [id] 示例的唯一标识符
  /// 返回 [Result] 包含示例实体或错误信息
  Future<Result<ExampleEntity>> fetchExampleById(String id);

  /// 创建新的示例数据
  ///
  /// [name] 名称
  /// [description] 描述信息
  /// 返回 [Result] 包含创建的示例实体或错误信息
  Future<Result<ExampleEntity>> createExample({
    required String name,
    required String description,
  });
}
