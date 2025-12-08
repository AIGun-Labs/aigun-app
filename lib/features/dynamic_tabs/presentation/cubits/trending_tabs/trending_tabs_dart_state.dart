part of 'trending_tabs_dart_cubit.dart';

enum TrendingTabsDartStatus { initial, loading, success, failure }

@freezed
class TrendingTabsDartState with _$TrendingTabsDartState {
  @override
  final TrendingTabsDartStatus status;
  @override
  final List<OptionTabItemEntity> tabs;
  @override
  final String? selectedValue;
  @override
  final String? errorMessage;
  const TrendingTabsDartState({
    this.status = TrendingTabsDartStatus.initial,
    this.tabs = const [],
    this.selectedValue,
    this.errorMessage,
  });
}
