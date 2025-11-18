import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/logger.dart';
import '../../domain/entities/config_entity.dart';
import '../../domain/usecases/can_install_from_unknown_sources.dart';
import '../../domain/usecases/check_for_update.dart';
import '../../domain/usecases/download_update.dart';
import '../../domain/usecases/installer_apk.dart';
import '../../domain/usecases/open_install_settings.dart';
import '../../domain/usecases/verify_checksum.dart';
import 'update_state.dart';

/// 应用更新管理 Cubit
/// 负责检查更新、下载更新包、校验文件完整性等功能
class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit(this._check, this._download, this._verify, this._install,
      this._canInstall, this._openSettings)
      : super(const UpdateState.initial());

  final CheckForUpdate _check; // 检查更新用例
  final DownloadUpdate _download; // 下载更新用例
  final VerifyChecksum _verify; // 校验和验证用例
  final InstallerApk _install; // 安装更新用例
  final CanInstallFromUnknownSources _canInstall; // 检查是否可以安装未知来源用例
  final OpenInstallSettings _openSettings; // 打开安装设置用例

  StreamSubscription<double>? _progressSub; // 下载进度订阅
  ConfigEntity? _info; // 当前更新信息

  /// 检查是否有可用更新
  Future<void> checkForUpdate() async {
    if (Platform.isIOS) {
      //ios更新不可用
      emit(const UpdateState.iosUnavailable());
      return;
    }
    emit(const UpdateState.checking());

    try {
      final latest = await _check.call();
      if (latest == null) {
        // 已是最新版本
        emit(const UpdateState.noUpdate());
        return;
      }

      _info = latest;

      emit(UpdateState.available(info: latest, force: latest.force));
    } catch (e) {
      emit(UpdateState.error(message: 'check for update failed: $e'));
    }
  }

  /// 开始下载更新包
  Future<void> startDownload() async {
    if (state is! UpdateAvailable || _info == null) {
      emit(const UpdateState.error(message: 'no update available'));
      return;
    }
    emit(const UpdateState.downloading(progress: 0));

    // 订阅下载进度
    await _progressSub?.cancel();

    _progressSub = _download.progress$.listen((p) {
      final safe = p.isNaN ? 0.0 : p; // 防止 NaN 值
      emit(UpdateState.downloading(progress: safe));
    });

    try {
      // 执行下载
      final path =
          await _download.call(url: _info!.url, filename: _info!.filename);

      await _progressSub?.cancel();

      if (path == null) {
        emit(const UpdateState.error(
            message: 'download failed, please try again later'));
        return;
      }

      // 验证文件完整性
      await verifyChecksum(path);
    } catch (e) {
      await _progressSub?.cancel();
      emit(UpdateState.error(message: 'download process exception: $e'));
    }
  }

  //安装包校验和验证
  Future<void> verifyChecksum(String path) async {
    final ok = await _verify.call(path);
    if (!ok) {
      emit(const UpdateState.error(
          message: 'file integrity verification failed'));
      return;
    }
    await checkCanInstall(path);
  }

  //检查是否可以安装未知来源
  Future<void> checkCanInstall(String path) async {
    final canInstall = await _canInstall.call();
    if (!canInstall) {
      emit(UpdateState.installNeedsPermission(path: path));
      return;
    }

    await installApk(path);
  }

  /// 发起安装
  Future<void> installApk(String path) async {
    try {
      await _install.call(path);
    } on PlatformException catch (e) {
      if (e.code == 'needs_permission') {
        emit(UpdateState.installNeedsPermission(path: path));
      } else {
        emit(UpdateState.error(message: e.code));
      }
    } catch (e) {
      emit(UpdateState.error(message: 'failed: $e'));
    } finally {
      emit(const UpdateState.initial());
    }
  }

  /// 引导去设置授权"允许此来源安装"
  Future<void> openInstallPermissionSettings() async {
    await _openSettings.call();
  }

  /// 从设置返回后重新检查权限并继续安装
  /// 如果当前状态是 installNeedsPermission，重新检查权限
  Future<void> resumeInstallFromSettings() async {
    final currentState = state;
    if (currentState is UpdateInstallNeedsPermission) {
      final path = currentState.path;

      final canInstall = await _canInstall.call();

      if (canInstall) {
        // 有权限了，直接安装
        await installApk(path);
      } else {
        Logger.info(
            'still no permission, staying in installNeedsPermission state');
        // 没有权限，保持原状态
      }
    }
  }

  @override
  Future<void> close() async {
    await _progressSub?.cancel();
    return super.close();
  }
}
