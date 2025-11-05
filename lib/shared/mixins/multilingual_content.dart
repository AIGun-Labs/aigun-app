/// 多语言内容接口
///
/// 所有包含 zh、en 字段的多语言类型都应该实现此 mixin。
/// 实现此 mixin 后，可以使用 [MultilingualContentExtension] 提供的扩展方法。
///
/// Example:
/// ```dart
/// @freezed
/// class MyMultilingualModel with _$MyMultilingualModel, IMultilingualContent {
///   const MyMultilingualModel._();
///
///   const factory MyMultilingualModel({
///     String? zh,
///     String? en,
///   }) = _MyMultilingualModel;
/// }
///
/// // 使用
/// if (model.isEmpty) {
///   // 处理空内容
/// }
/// String text = model.getText(context);
/// ```
mixin IMultilingualContent {
  /// 中文内容
  String? get zh;

  /// 英文内容
  String? get en;
}
