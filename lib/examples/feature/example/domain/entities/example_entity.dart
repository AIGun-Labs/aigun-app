import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_entity.freezed.dart';

/// 示例业务实体
///
/// 这是领域层的核心实体，代表业务概念，不依赖任何框架或外部库
/// Entity 是纯 Dart 对象，包含业务逻辑和验证规则
@freezed
sealed class ExampleEntity with _$ExampleEntity {
  const ExampleEntity._();

  /// 创建示例实体
  ///
  /// [id] 唯一标识符
  /// [name] 名称
  /// [description] 描述信息
  const factory ExampleEntity({
    required String id,
    required String name,
    required String description,
  }) = _ExampleEntity;

  /// 验证实体是否有效
  ///
  /// 返回 true 如果实体数据有效
  bool get isValid => id.isNotEmpty && name.isNotEmpty;
}
