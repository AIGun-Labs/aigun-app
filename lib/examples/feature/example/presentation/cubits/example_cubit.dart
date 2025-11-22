import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/logger.dart';
import '../../domain/entities/example_entity.dart';
import '../../domain/usecases/create_example.dart';
import '../../domain/usecases/fetch_example_by_id.dart';
import '../../domain/usecases/fetch_examples.dart';

part 'example_cubit.freezed.dart';
part 'example_state.dart';

/// 示例功能 Cubit
///
/// 管理示例功能的状态和业务逻辑
/// 使用 BLoC 模式进行状态管理
class ExampleCubit extends Cubit<ExampleState> {
  final FetchExamples _fetchExamples;
  final FetchExampleById _fetchExampleById;
  final CreateExample _createExample;

  /// 创建示例 Cubit
  ///
  /// [fetchExamples] 获取示例列表用例
  /// [fetchExampleById] 根据 ID 获取示例用例
  /// [createExample] 创建示例用例
  ExampleCubit(
    this._fetchExamples,
    this._fetchExampleById,
    this._createExample,
  ) : super(const ExampleState.initial());

  /// 初始化并加载数据
  ///
  /// 通常在页面初始化时调用
  Future<void> init() async {
    Logger.info('ExampleCubit init');
    emit(const ExampleState.loading());
    await fetchExamples();
  }

  /// 获取示例列表
  ///
  /// 从服务器获取所有示例数据并更新状态
  Future<void> fetchExamples() async {
    final result = await _fetchExamples.call();

    result.when(
      success: (List<ExampleEntity> examples) {
        emit(ExampleState.success(examples));
      },
      loading: () {
        emit(const ExampleState.loading());
      },
      failure: (String message) {
        emit(ExampleState.error(message));
      },
    );
  }

  /// 根据 ID 获取单个示例
  ///
  /// [id] 示例的唯一标识符
  Future<void> fetchExampleById(String id) async {
    emit(const ExampleState.loading());
    final result = await _fetchExampleById.call(id);

    result.when(
      success: (ExampleEntity example) {
        emit(ExampleState.exampleLoaded(example));
      },
      loading: () {
        emit(const ExampleState.loading());
      },
      failure: (String message) {
        emit(ExampleState.error(message));
      },
    );
  }

  /// 创建新示例
  ///
  /// [name] 名称
  /// [description] 描述信息
  Future<void> createExample({
    required String name,
    required String description,
  }) async {
    emit(const ExampleState.loading());
    final result = await _createExample.call(
      name: name,
      description: description,
    );

    result.when(
      success: (ExampleEntity example) {
        // 创建成功后，可以选择刷新列表或直接添加
        fetchExamples();
      },
      loading: () {
        emit(const ExampleState.loading());
      },
      failure: (String message) {
        emit(ExampleState.error(message));
      },
    );
  }
}
