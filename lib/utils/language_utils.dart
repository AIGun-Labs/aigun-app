import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/utils/language.dart';

class LanguageUtils {
  static String getAIAgentName(BuildContext context, AIAgent? aiAgent) {
    if (aiAgent == null || aiAgent.name == null || aiAgent.name!.isEmpty) {
      return '';
    }

    final languageCode = Language.getLanguageCode(context);
    return aiAgent.name![languageCode] ?? aiAgent.name!['en'] ?? '';
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
}
