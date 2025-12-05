import 'package:flutter/material.dart';

import '../../utils/language.dart';
import '../mixins/multilingual_content.dart';

///

extension MultilingualContentExtension on IMultilingualContent {
  ///

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

  ///

  ///
  /// Parameters:

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
