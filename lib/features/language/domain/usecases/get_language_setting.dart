import '../../../../core/types/result.dart';
import '../entities/language_setting_entity.dart';
import '../repositories/language_repo.dart';

final class GetLanguageSetting {
  GetLanguageSetting(this._repo);
  final LanguageRepo _repo;

  Future<Result<LanguageSettingEntity>> call() => _repo.getSetting();
}
