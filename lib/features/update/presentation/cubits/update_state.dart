part of 'update_cubit.dart';

@freezed
class UpdateState with _$UpdateState {
  const factory UpdateState.initial() = UpdateInitial;
  const factory UpdateState.iosUnavailable() = UpdateIosUnavailable;
  const factory UpdateState.checking() = UpdateChecking;
  const factory UpdateState.noUpdate() = UpdateNoUpdate;
  const factory UpdateState.available({
    required ConfigEntity info,
    required bool force,
  }) = UpdateAvailable;
  const factory UpdateState.downloading({
    required double progress, // 0..1
  }) = UpdateDownloading;
  const factory UpdateState.installNeedsPermission({required String path}) =
      UpdateInstallNeedsPermission;
  const factory UpdateState.error({required String message}) = UpdateError;
}
