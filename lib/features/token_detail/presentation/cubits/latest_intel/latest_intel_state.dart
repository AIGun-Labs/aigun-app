part of 'latest_intel_cubit.dart';

@freezed
class LatestIntelState with _$LatestIntelState {
  const factory LatestIntelState.initial() = _Initial;
  const factory LatestIntelState.loading() = _Loading;
  const factory LatestIntelState.success(IntelV2Entity intel) = _Success;
  const factory LatestIntelState.error(String message) = _Error;
}
