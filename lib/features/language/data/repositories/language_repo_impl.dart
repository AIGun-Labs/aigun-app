import '../../../../core/types/result.dart';
import '../../domain/entities/language_setting_entity.dart';
import '../../domain/repositories/language_repo.dart';
import '../sources/language_local_source.dart';

class LanguageRepoImpl implements LanguageRepo {
  LanguageRepoImpl(this._localSource);
  final LanguageLocalSource _localSource;

  @override
  Future<Result<LanguageSettingEntity>> getSetting() async {
    try {
      final setting = await _localSource.get();
      return Result.success(setting);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> setSetting(LanguageSettingEntity setting) async {
    try {
      await _localSource.save(setting);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<LanguageSettingEntity>> loadSetting() async {
    try {
      final setting = await _localSource.load();
      return Result.success(setting);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
