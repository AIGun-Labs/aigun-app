import 'package:get_it/get_it.dart';

import '../../../data/services/index.dart';
import '../../../features/candlestick/application/usecases/fetch_history_candlesticks.dart';
import '../../../features/candlestick/application/usecases/fetch_latest_candlesticks.dart';
import '../../../features/candlestick/domain/repositories/candlestick_repository.dart';
import '../../../features/candlestick/infrastructure/datasource/candlestick_remote_data_source.dart';
import '../../../features/candlestick/infrastructure/repositories/candlestick_repository_impl.dart';
import '../../../features/candlestick/presentation/cubit/candlestick/candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/history/history_candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/latest/latest_candlestick_cubit.dart';
import '../../../features/candlestick/presentation/cubit/selection/selection_params_cubit.dart';
import '../module_repo.dart';

class CandlestickModule implements InjectionModule {
  final GetIt _sl;

  CandlestickModule(this._sl);

  @override
  Future<void> init() async {
    // 数据源
    _sl
      // 数据源
      ..registerLazySingleton(
        () => CandlestickRemoteDataSource(_sl<DioClient>()),
      )
      // 仓库
      ..registerLazySingleton<CandlestickRepository>(
        () => CandlestickRepositoryImpl(_sl<CandlestickRemoteDataSource>()),
      )
      // 用例
      ..registerLazySingleton(() => FetchHistoryCandlesticks(_sl()))
      ..registerLazySingleton(() => FetchLatestCandlesticks(_sl()))
      // Cubit
      ..registerLazySingleton(() => SelectionParamsCubit())
      ..registerLazySingleton(() => HistoryCandlestickCubit(_sl()))
      ..registerLazySingleton(() => LatestCandlestickCubit(_sl()))
      // 使用 factory 是因为要在 route 中使用
      ..registerFactory(
        () => CandlestickCubit(
          selectionParamsCubit: _sl<SelectionParamsCubit>(),
          historyCubit: _sl<HistoryCandlestickCubit>(),
          latestCubit: _sl<LatestCandlestickCubit>(),
        ),
      );
  }
}
