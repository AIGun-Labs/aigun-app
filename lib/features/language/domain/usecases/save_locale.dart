import 'dart:ui';

import '../../../../core/types/result.dart';
import '../repositories/language_repo.dart';

final class SaveLocale {
  SaveLocale(this._repo);
  final LanguageRepo _repo;

  Future<Result<void>> call(Locale locale) => _repo.saveLocale(locale);
}
