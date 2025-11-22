import 'package:freezed_annotation/freezed_annotation.dart';

/// 示例转换器
///
/// 用于自定义 JSON 序列化/反序列化逻辑
/// 当需要特殊的数据转换时使用（例如：枚举、日期、自定义类型等）
///
/// 如果不需要特殊转换，可以删除此文件
class ExampleConverter implements JsonConverter<String, Object?> {
  const ExampleConverter();

  @override
  String fromJson(Object? json) {
    // 自定义转换逻辑
    return (json ?? '').toString();
  }

  @override
  Object toJson(String object) {
    // 自定义转换逻辑
    return object;
  }
}
