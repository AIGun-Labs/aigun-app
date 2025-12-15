import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';
import '../repositories/language_repo.dart';

final class SaveLanguageSetting {
  SaveLanguageSetting(this._repo);

  final LanguageRepo _repo;

  Future<Result<void>> call(LanguageSettingEntity setting) =>
      _repo.setSetting(setting);
}
