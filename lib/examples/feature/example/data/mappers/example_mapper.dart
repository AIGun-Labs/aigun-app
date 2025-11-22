import '../../domain/entities/example_entity.dart';
import '../models/example_model.dart';

/// 示例模型到实体的映射扩展
///
/// Mapper 负责将 Data Layer 的 Model 转换为 Domain Layer 的 Entity
/// 这是 Clean Architecture 中数据转换的关键部分
extension ExampleMapper on ExampleModel {
  /// 将模型转换为实体
  ///
  /// 返回对应的业务实体实例
  ExampleEntity toEntity() {
    return ExampleEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}

/// 实体到模型的映射扩展（如果需要）
extension ExampleEntityMapper on ExampleEntity {
  /// 将实体转换为模型
  ///
  /// 返回对应的数据模型实例
  ExampleModel toModel() {
    return ExampleModel(
      id: id,
      name: name,
      description: description,
    );
  }
}
