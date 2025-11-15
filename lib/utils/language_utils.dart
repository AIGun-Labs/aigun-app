import 'package:flutter/material.dart';

import '../data/models/intel/intel.dart';
import '../data/models/language/language.dart';
import 'language.dart';

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

    String text = '';

    if (languageCode == Language.zh) {
      text = content?.zh ?? '';
    } else if (languageCode == Language.en) {
      text = content?.en ?? '';
    } else {
      text = content?.original ?? '';
    }
    if (text.isEmpty) {
      text = content?.original ?? '';
    }

    return text;
  }

  static String getAnalyzedText(BuildContext context, Analyzed? analyzed) {
    final languageCode = Language.getLanguageCode(context);

    String text = '';

    if (languageCode == Language.zh) {
      text = analyzed?.zh ?? '';
    } else if (languageCode == Language.en) {
      text = analyzed?.en ?? '';
    } else {
      text = analyzed?.en ?? '';
    }

    if (text.isEmpty) {
      text = analyzed?.en ?? '';
    }

    return text;
  }

  static bool isEmpty(Multilingual? analyzed) {
    return analyzed?.isEmpty ?? true;
  }
}
