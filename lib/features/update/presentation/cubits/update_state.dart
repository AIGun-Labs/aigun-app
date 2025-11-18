import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/config_entity.dart';

part 'update_state.freezed.dart';

@freezed
class UpdateState with _$UpdateState {
  //初始状态
  const factory UpdateState.initial() = UpdateInitial;

  //ios更新不可用状态
  const factory UpdateState.iosUnavailable() = UpdateIosUnavailable;

  //检测中状态
  const factory UpdateState.checking() = UpdateChecking;

  //没有更新状态
  const factory UpdateState.noUpdate() = UpdateNoUpdate;

  //有更新状态
  const factory UpdateState.available({
    required ConfigEntity info,
    required bool force,
  }) = UpdateAvailable;

  //下载更新状态
  const factory UpdateState.downloading({
    required double progress, // 0..1
  }) = UpdateDownloading;

  //安装需要权限状态
  const factory UpdateState.installNeedsPermission({required String path}) =
      UpdateInstallNeedsPermission;

  //错误状态
  const factory UpdateState.error({
    required String message,
  }) = UpdateError;
}
