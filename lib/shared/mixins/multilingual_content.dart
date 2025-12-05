///

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

/// if (model.isEmpty) {

/// }
/// String text = model.getText(context);
/// ```
mixin IMultilingualContent {
  String? get zh;

  String? get en;
}
