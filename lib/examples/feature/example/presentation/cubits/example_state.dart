part of 'example_cubit.dart';

///

@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;

  const factory ExampleState.loading() = _Loading;

  ///

  const factory ExampleState.success(List<ExampleEntity> examples) = _Success;

  ///

  const factory ExampleState.exampleLoaded(ExampleEntity example) =
      _ExampleLoaded;

  ///

  const factory ExampleState.error(String message) = _Error;
}
