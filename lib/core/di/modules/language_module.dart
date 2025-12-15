import 'package:get_it/get_it.dart';

import '../../../features/language/data/repositories/language_repo_impl.dart';
import '../../../features/language/data/sources/language_local_source.dart';
import '../../../features/language/domain/repositories/language_repo.dart';
import '../../../features/language/domain/usecases/get_language_setting.dart';
import '../../../features/language/domain/usecases/save_language_setting.dart';
import '../../../features/language/presentation/controllers/locale_controller.dart';
import '../module_repo.dart';

class LanguageModule implements InjectionModule {
  LanguageModule(this._sl);
  final GetIt _sl;

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => LanguageLocalSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton<LanguageRepo>(() => LanguageRepoImpl(_sl()));

    /// Use cases
    _sl.registerLazySingleton(() => GetLanguageSetting(_sl()));
    _sl.registerLazySingleton(() => SaveLanguageSetting(_sl()));

    /// Controllers
    _sl.registerSingleton(LocaleController(_sl(), _sl())..init());
  }
}
