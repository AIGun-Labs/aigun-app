import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';

abstract interface class LanguageRepo {
  Future<Result<LanguageSettingEntity>> getSetting(bool? d);

  Future<Result<void>> setSetting(LanguageSettingEntity setting);
}
