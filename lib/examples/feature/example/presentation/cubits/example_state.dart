part of 'example_cubit.dart';

/// 示例功能状态
///
/// 使用 Freezed 定义所有可能的状态
/// 包括：初始状态、加载中、成功、错误、单个示例加载等
@freezed
class ExampleState with _$ExampleState {
  /// 初始状态
  const factory ExampleState.initial() = _Initial;

  /// 加载中状态
  const factory ExampleState.loading() = _Loading;

  /// 成功状态（包含示例列表）
  ///
  /// [examples] 示例实体列表
  const factory ExampleState.success(List<ExampleEntity> examples) = _Success;

  /// 单个示例加载成功
  ///
  /// [example] 示例实体
  const factory ExampleState.exampleLoaded(ExampleEntity example) =
      _ExampleLoaded;

  /// 错误状态
  ///
  /// [message] 错误信息
  const factory ExampleState.error(String message) = _Error;
}
