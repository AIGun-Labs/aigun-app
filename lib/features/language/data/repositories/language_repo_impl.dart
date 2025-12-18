import 'dart:ui';

import '../../../../core/types/result.dart';
import '../../domain/entities/language_setting_entity.dart';
import '../../domain/repositories/language_repo.dart';
import '../sources/language_local_source.dart';

class LanguageRepoImpl implements LanguageRepo {
  LanguageRepoImpl(this._localSource);
  final LanguageLocalSource _localSource;

  @override
  Future<Result<void>> setSetting(LanguageSettingEntity setting) async {
    try {
      await _localSource.saveSetting(setting);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<LanguageSettingEntity>> loadSetting() async {
    try {
      final setting = await _localSource.loadSetting();
      return Result.success(setting);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> setFollowSystem(bool followSystem) async {
    try {
      await _localSource.saveFollowSystem(followSystem);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> saveLocale(Locale locale) async {
    try {
      await _localSource.saveLocale(locale);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
