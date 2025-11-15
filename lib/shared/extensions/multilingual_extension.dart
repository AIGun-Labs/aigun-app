import 'package:flutter/material.dart';

import '../../utils/language.dart';
import '../mixins/multilingual_content.dart';

/// 多语言内容扩展方法
///
/// 为实现 [IMultilingualContent] 的类型提供通用的工具方法。
extension MultilingualContentExtension on IMultilingualContent {
  /// 判断多语言内容是否为空
  ///
  /// 当 zh 和 en 字段都为 null 或空字符串时返回 true
  ///
  /// Example:
  /// ```dart
  /// if (analyzed.isEmpty) {
  ///   print('No content available');
  /// }
  /// ```
  bool get isEmpty {
    final zhEmpty = zh == null || zh!.isEmpty;
    final enEmpty = en == null || en!.isEmpty;
    return zhEmpty && enEmpty;
  }

  /// 根据当前语言获取对应的文本内容
  ///
  /// 优先返回当前语言的内容，如果为空则回退到英文。
  /// 如果所有内容都为空，返回空字符串。
  ///
  /// Parameters:
  ///   - [context]: BuildContext，用于获取当前语言设置
  ///
  /// Example:
  /// ```dart
  /// String content = multilingual.getText(context);
  /// ```
  String getText(BuildContext context) {
    final languageCode = Language.getLanguageCode(context);

    switch (languageCode) {
      case Language.zh:
        return zh ?? en ?? '';
      case Language.en:
        return en ?? '';
      default:
        return en ?? '';
    }
  }
}
