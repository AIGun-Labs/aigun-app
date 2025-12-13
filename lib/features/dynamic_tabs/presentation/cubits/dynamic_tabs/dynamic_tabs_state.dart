part of 'dynamic_tabs_cubit.dart';

enum DynamicTabsStatus { initial, loading, success, failure }

@freezed
class DynamicTabsState with _$DynamicTabsState {
  @override
  final DynamicTabsStatus status;

  @override
  final OptionTabEntity? tabs;

  @override
  final String? selectedValue;

  @override
  final String? errorMessage;

  const DynamicTabsState({
    this.status = DynamicTabsStatus.initial,
    this.tabs,
    this.selectedValue,
    this.errorMessage,
  });
}
