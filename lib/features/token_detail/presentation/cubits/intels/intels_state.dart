part of 'intels_cubit.dart';

enum IntelsStatus { initial, loading, success, error }

@freezed
class IntelsState with _$IntelsState {
  @override
  final IntelsStatus status;

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

  @override
 final IntelV2Entity? latestIntel;

  const IntelsState({
    this.status = IntelsStatus.initial,
    this.intels = const [],
    this.network = '',
    this.address = '',
    this.errorMessage = '',
    this.count,
    this.intelsPage = 1,
    this.intelsPageSize = 10,
    this.isNotMore = false,
    this.latestIntel,
  });
}
