import 'package:get_it/get_it.dart';

import '../../../features/dynamic_tabs/data/repositories/option_tab_repo_impl.dart';
import '../../../features/dynamic_tabs/data/sources/option_tab_local_source.dart';
import '../../../features/dynamic_tabs/data/sources/option_tab_remote_source.dart';
import '../../../features/dynamic_tabs/domain/repositories/option_tab_repo.dart';
import '../../../features/dynamic_tabs/domain/usecases/get_option_tab.dart';
import '../../../features/dynamic_tabs/presentation/cubits/dynamic_tabs/dynamic_tabs_cubit.dart';
import '../../../features/dynamic_tabs/presentation/cubits/top_tab_action/top_tab_action_cubit.dart';
import '../module_repo.dart';

class DynamicTabsModule implements InjectionModule {
  final GetIt _sl;

  DynamicTabsModule(this._sl);

  @override
  Future<void> init() async {
    /// Data sources
    _sl.registerLazySingleton(() => OptionTabRemoteSource(_sl()));
    _sl.registerLazySingleton(() => OptionTabLocalSource(_sl()));

    /// Repositories
    _sl.registerLazySingleton<OptionTabRepo>(
      () => OptionTabRepoImpl(_sl(), _sl()),
    );

    /// Use cases
    _sl.registerLazySingleton(() => GetOptionTab(_sl()));

    /// Cubits
    _sl.registerSingleton(DynamicTabsCubit(_sl())..init());

    _sl.registerFactory(() => TopTabActionCubit());
  }
}
