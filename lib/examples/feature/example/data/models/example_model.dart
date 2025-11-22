import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_model.freezed.dart';
part 'example_model.g.dart';

/// 示例数据模型
///
/// Model 是 Data Layer 的数据结构，用于序列化/反序列化 JSON
/// 与 Entity 不同，Model 可以包含 JSON 注解和转换逻辑
@freezed
class ExampleModel with _$ExampleModel {
  /// 创建示例模型
  ///
  /// [id] 唯一标识符
  /// [name] 名称
  /// [description] 描述信息
  const factory ExampleModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') required String description,
  }) = _ExampleModel;

  /// 从 JSON 创建模型实例
  ///
  /// [json] JSON 数据映射
  /// 返回解析后的模型实例
  factory ExampleModel.fromJson(Map<String, dynamic> json) =>
      _$ExampleModelFromJson(json);
}
