part of 'intels_cubit.dart';

enum IntelsStatus { initial, loading, success, error }

@freezed
class IntelsState with _$IntelsState {
  @override
  final IntelsStatus status;
  @override
  final List<Intel> intels;
  @override
  final String errorMessage;
  @override
  final int? count;

  const IntelsState({
    this.status = IntelsStatus.initial,
    this.intels = const [],
    this.errorMessage = '',
    this.count,
  });
}
