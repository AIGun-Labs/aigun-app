import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/update_info.dart';

part 'update_state.freezed.dart';

@freezed
class UpdateState with _$UpdateState {
  const factory UpdateState.initial() = UpdateInitial;

  const factory UpdateState.checking() = UpdateChecking;

  const factory UpdateState.noUpdate() = UpdateNoUpdate;

  const factory UpdateState.available({
    required UpdateInfo info,
    required bool force,
  }) = UpdateAvailable;

  const factory UpdateState.downloading({
    required UpdateInfo info,
    required double progress, // 0..1
  }) = UpdateDownloading;

  const factory UpdateState.paused({
    required UpdateInfo info,
    required double progress,
  }) = UpdatePaused;

  const factory UpdateState.verifying({
    required UpdateInfo info,
  }) = UpdateVerifying;

  const factory UpdateState.downloaded({
    required UpdateInfo info,
    required String path,
  }) = UpdateDownloaded;

  const factory UpdateState.checksumFailed({
    required UpdateInfo info,
  }) = UpdateChecksumFailed;

  const factory UpdateState.canceled() = UpdateCanceled;

  const factory UpdateState.error({
    required String message,
  }) = UpdateError;

  const factory UpdateState.installing({required String path}) =
      UpdateInstalling;

  const factory UpdateState.installNeedsPermission({required String path}) =
      UpdateInstallNeedsPermission;

  const factory UpdateState.installLaunched() = UpdateInstallLaunched;
}
