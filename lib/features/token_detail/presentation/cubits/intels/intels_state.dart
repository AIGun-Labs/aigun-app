part of 'intels_cubit.dart';

enum IntelsStatus { initial, loading, success, error }

enum TokenAssociatedIntelsStatus { initial, loading, success, error }

@freezed
class IntelsState with _$IntelsState {
  @override
  final IntelsStatus status;

  @override
  final TokenAssociatedIntelsStatus tokenAssociatedIntelsStatus;

  @override
  final int intelsPage;

  @override
  final int intelsPageSize;

  @override
  final List<Intel> intels;
  @override
  final String errorMessage;
  @override
  final int? count;
  @override
  final bool isNotMore;

  @override
  final String network;
  @override
  final String address;

  const IntelsState({
    this.status = IntelsStatus.initial,
    this.tokenAssociatedIntelsStatus = TokenAssociatedIntelsStatus.initial,
    this.intels = const [],
    this.network = '',
    this.address = '',
    this.errorMessage = '',
    this.count,
    this.intelsPage = 1,
    this.intelsPageSize = 10,
    this.isNotMore = false,
  });
}
