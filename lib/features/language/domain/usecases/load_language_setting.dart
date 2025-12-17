import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';
import '../repositories/language_repo.dart';

final class LoadLanguageSetting {
  LoadLanguageSetting(this._repo);
  final LanguageRepo _repo;

  Future<Result<LanguageSettingEntity>> call() => _repo.loadSetting();
}
