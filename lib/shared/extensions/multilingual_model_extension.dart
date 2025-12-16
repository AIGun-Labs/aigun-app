import 'package:flutter/widgets.dart';

import '../data/models/multilingual_model.dart';
import '../utils/locale_util.dart';

extension MultilingualModelExtension on MultilingualModel? {
  String getByLocale(BuildContext context) =>
      LocaleUtil.getTextByLanguage(context, this);
}
