import 'package:get_it/get_it.dart';

import '../../../features/chain/application/usecases/get_supported_chains.dart';
import '../../../features/chain/domain/repositories/chain_repository.dart';
import '../../../features/chain/infrastructure/datasources/chain_remote_data_source.dart';
import '../../../features/chain/infrastructure/repositories/chain_repository_impl.dart';
import '../../../features/chain/presentation/cubit/supported_chains_cubit.dart';
import '../module_repo.dart';

class ChainModule implements InjectionModule {
  ChainModule(this._sl);
  final GetIt _sl;

  @override
  Future<void> init() async {
    _sl.registerLazySingleton(() => ChainRemoteDataSource(_sl()));

    _sl.registerLazySingleton<ChainRepository>(
      () => ChainRepositoryImpl(_sl<ChainRemoteDataSource>()),
    );

    _sl.registerLazySingleton(() => GetSupportedChains(_sl<ChainRepository>()));

    _sl.registerLazySingleton(
      () => SupportedChainsCubit(_sl<GetSupportedChains>())..initialize(),
    );
  }
}
