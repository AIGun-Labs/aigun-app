import 'dart:ui';

import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';

abstract interface class LanguageRepo {
  Future<Result<void>> setSetting(LanguageSettingEntity setting);

  Future<Result<LanguageSettingEntity>> loadSetting();

  Future<Result<void>> setFollowSystem(bool followSystem);

  Future<Result<void>> saveLocale(Locale locale);
}
