import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/logger.dart';
import '../../domain/entities/update_info.dart';
import '../../domain/usecases/can_install_from_unkown_sources.dart';
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
  final CanInstallFromUnkownSources _canInstall; // 检查是否可以安装未知来源用例
  final OpenInstallSettings _openSettings; // 打开安装设置用例

  StreamSubscription<double>? _progressSub; // 下载进度订阅
  UpdateInfo? _info; // 当前更新信息
  UpdateInfo? get info => _info;

  /// 检查是否有可用更新
  Future<void> checkForUpdate() async {
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
    final info = _info;
    Logger.info('startDownload, info: ${info?.latest}');

    if (info == null) {
      Logger.error('info is null, cannot download');
      return;
    }

    Logger.info('sending downloading state, progress: 0.0');
    emit(UpdateState.downloading(progress: 0, info: info));

    // 订阅下载进度
    await _progressSub?.cancel();

    _progressSub = _download.progress$.listen(
      (p) {
        final safe = p.isNaN ? 0.0 : p; // 防止 NaN 值
        Logger.info('cubit received download progress: $safe');
        emit(UpdateState.downloading(progress: safe, info: info));
      },
      onError: (e) {
        Logger.error('download progress stream error: $e');
      },
      onDone: () {
        Logger.info('download progress stream done');
      },
    );

    try {
      Logger.info(
          'starting download: url=${info.url}, filename=${info.filename}');
      // 执行下载
      final path = await _download.call(url: info.url, filename: info.filename);
      await _progressSub?.cancel();

      if (path == null) {
        emit(const UpdateState.error(
            message: 'download failed, please try again later'));
        return;
      }

      // 验证文件完整性
      await verifyChecksum(path: path);
    } catch (e) {
      emit(UpdateState.error(message: 'download process exception: $e'));
    }
  }

  //安装包校验和验证
  Future<void> verifyChecksum({required String path}) async {
    if (_info == null) {
      emit(const UpdateState.error(message: 'info is null'));
      return;
    }

    emit(UpdateState.verifying(info: _info!));
    final ok = await _verify.call(path, _info!.sha256);
    if (!ok) {
      emit(const UpdateState.error(
          message: 'file integrity verification failed'));
      return;
    }
    emit(UpdateState.downloaded(path: path, info: _info!));
  }

  //检查是否可以安装未知来源
  Future<void> checkCanInstall({required String path}) async {
    final canInstall = await _canInstall.call();
    Logger.info('can install from unknown sources: $canInstall');
    if (!canInstall) {
      Logger.info('cannot install from unknown sources, requesting permission');
      emit(UpdateState.installNeedsPermission(path: path));
      return;
    }
    emit(UpdateState.installing(path: path));
  }

  /// 发起安装
  Future<void> install({required String path}) async {
    // String apkPath = path;
    Logger.info('installing apk: $path');
    try {
      await _install.call(path);
      Logger.info('installer launched');
      emit(const UpdateState.installLaunched());
    } on PlatformException catch (e) {
      if (e.code == 'needs_permission') {
        emit(UpdateState.installNeedsPermission(path: path));
      } else if (e.code == 'file_not_found') {
        emit(const UpdateState.error(message: 'installer file not found'));
      } else if (e.code == 'no_handler') {
        emit(const UpdateState.error(message: 'no installer handler found'));
      } else if (e.code == 'security_error') {
        emit(const UpdateState.error(message: 'security error'));
      } else {
        emit(UpdateState.error(message: 'installer failed: ${e.code}'));
      }
    } catch (e) {
      emit(UpdateState.error(message: 'installer failed: $e'));
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
      Logger.info('resuming install from settings, path: $path');

      final canInstall = await _canInstall.call();
      Logger.info(
          'can install from unknown sources after settings: $canInstall');

      if (canInstall) {
        // 有权限了，直接安装
        await install(path: path);
      } else {
        Logger.info(
            'still no permission, staying in installNeedsPermission state');
        // 没有权限，保持原状态
      }
    }
  }

  /// 暂停下载
  Future<void> pause() async {
    await _download.pause();
    final s = state;
    if (s is UpdateDownloading) {
      emit(UpdateState.paused(info: s.info, progress: s.progress));
    }
  }

  /// 恢复下载
  Future<void> resume() async {
    await _download.resume();
    final s = state;
    if (s is UpdatePaused) {
      emit(UpdateState.downloading(info: s.info, progress: s.progress));
    }
  }

  /// 取消下载
  Future<void> cancel() async {
    await _download.cancel();
    emit(const UpdateState.canceled());
  }

  @override
  Future<void> close() async {
    await _progressSub?.cancel();
    return super.close();
  }
}
