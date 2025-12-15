import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';

abstract interface class LanguageRepo {
  Future<Result<LanguageSettingEntity>> getSetting();

  Future<Result<void>> setSetting(LanguageSettingEntity setting);
}
