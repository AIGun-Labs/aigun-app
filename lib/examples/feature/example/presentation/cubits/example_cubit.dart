import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/types/result.dart';
import '../../../../../utils/logger.dart';
import '../../domain/entities/example_entity.dart';
import '../../domain/usecases/create_example.dart';
import '../../domain/usecases/fetch_example_by_id.dart';
import '../../domain/usecases/fetch_examples.dart';

part 'example_cubit.freezed.dart';
part 'example_state.dart';

///

class ExampleCubit extends Cubit<ExampleState> {
  final FetchExamples _fetchExamples;
  final FetchExampleById _fetchExampleById;
  final CreateExample _createExample;

  ///

  ExampleCubit(this._fetchExamples, this._fetchExampleById, this._createExample)
    : super(const ExampleState.initial());

  ///

  Future<void> init() async {
    Logger.info('ExampleCubit init');
    emit(const ExampleState.loading());
    await fetchExamples();
  }

  ///

  Future<void> fetchExamples() async {
    final result = await _fetchExamples.call();

    result.whenOrNull(
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

  ///

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

  ///

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
