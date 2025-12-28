import 'package:get_it/get_it.dart';

import '../../../features/candlestick/application/usecases/fetch_history_candlesticks.dart';
import '../../../features/candlestick/application/usecases/fetch_latest_candlesticks.dart';
import '../../../features/candlestick/domain/repositories/candlestick_repository.dart';
import '../../../features/candlestick/infrastructure/datasource/candlestick_remote_data_source.dart';
import '../../../features/candlestick/infrastructure/repositories/candlestick_repository_impl.dart';
import '../../../features/candlestick/presentation/cubit/candlestick/candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/history/history_candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/latest/latest_candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/selection/selection_params_cubit.dart';
import '../../../features/token_detail/presentation/cubits/token_info/token_info_cubit.dart';
import '../module_repo.dart';

class CandlestickModule implements InjectionModule {
  CandlestickModule(this._sl);
  final GetIt _sl;

  @override
  Future<void> init() async {
    _sl
      ..registerLazySingleton(() => CandlestickRemoteDataSource(_sl()))
      ..registerLazySingleton<CandlestickRepository>(
        () => CandlestickRepositoryImpl(_sl<CandlestickRemoteDataSource>()),
      )
      ..registerLazySingleton(() => FetchHistoryCandlesticks(_sl()))
      ..registerLazySingleton(() => FetchLatestCandlesticks(_sl()))
      // Cubit
      ..registerLazySingleton(SelectionParamsCubit.new)
      ..registerLazySingleton(() => HistoryCandlestickCubit(_sl(), _sl()))
      ..registerLazySingleton(() => LatestCandlestickCubit(_sl()))
      ..registerFactoryParam<CandlestickCubit, TokenInfoCubit, void>(
        (tokenInfoCubit, _) => CandlestickCubit(
          selectionParamsCubit: _sl<SelectionParamsCubit>(),
          historyCubit: _sl<HistoryCandlestickCubit>(),
          latestCubit: _sl<LatestCandlestickCubit>(),
          onPriceUpdate: tokenInfoCubit.updateTokenPrice,
        ),
      );
  }
}
