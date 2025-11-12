import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/data/models/language/language.dart';
import 'package:flutter_aigun/shared/extensions/multilingual_extension.dart';
import 'package:flutter_aigun/utils/language.dart';

class LanguageUtils {
  static String getAIAgentName(BuildContext context, AIAgent? aiAgent) {
    if (aiAgent == null || aiAgent.name == null || aiAgent.name!.isEmpty) {
      return '';
    }

    final languageCode = Language.getLanguageCode(context);
    return aiAgent.name![languageCode] ?? aiAgent.name!['en'] ?? '';
  }

  static String getContentByLanguage(
      BuildContext context, Multilingual? content) {
    final languageCode = Language.getLanguageCode(context);

    switch (languageCode) {
      case Language.zh:
        return content?.zh ?? '';
      case Language.en:
        return content?.en ?? '';
      default:
        return content?.original ?? '';
    }
  }

  static String getAnalyzedText(BuildContext context, Analyzed? analyzed) {
    final languageCode = Language.getLanguageCode(context);

    switch (languageCode) {
      case Language.zh:
        return analyzed?.zh ?? '';
      case Language.en:
        return analyzed?.en ?? '';
      default:
        return analyzed?.en ?? '';
    }
  }

  static bool isEmpty(Multilingual? analyzed) {
    return analyzed?.isEmpty ?? true;
  }
}
