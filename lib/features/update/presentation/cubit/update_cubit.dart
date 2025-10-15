import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../utils/logger.dart';
import '../../domain/entities/update_info.dart';
import '../../domain/usecases/check_for_update.dart';
import '../../domain/usecases/download_update.dart';
import '../../domain/usecases/verify_checksum.dart';
import '../../../../utils/version_compare.dart';
import 'update_state.dart';

/// 应用更新管理 Cubit
/// 负责检查更新、下载更新包、校验文件完整性等功能
class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit(this._check, this._download, this._verify)
      : super(const UpdateState.initial());

  final CheckForUpdate _check; // 检查更新用例
  final DownloadUpdate _download; // 下载更新用例
  final VerifyChecksum _verify; // 校验和验证用例

  StreamSubscription<double>? _progressSub; // 下载进度订阅
  UpdateInfo? _info; // 当前更新信息

  /// 检查是否有可用更新
  ///
  /// 从服务器获取最新版本信息，并与当前版本对比
  /// 如果当前版本低于 minVersion，则标记为强制更新
  Future<void> checkForUpdate() async {
    emit(const UpdateState.checking());
    try {
      final latest = await _check();
      if (latest == null) {
        // 已是最新版本
        emit(const UpdateState.noUpdate());
        return;
      }
      _info = latest;

      // 强更判定（当前 versionName < min_version）
      final pkg = await PackageInfo.fromPlatform();
      Logger.info('当前版本: ${pkg.version}');
      // final force = (latest.minVersion != null &&
      //         compareSemver(pkg.version, latest.minVersion!) < 0) ||
      //     latest.force;

      final force = latest.force;

      emit(UpdateState.available(info: latest, force: force));
    } catch (e) {
      emit(UpdateState.error(message: '检查更新失败：$e'));
    }
  }

  /// 开始下载更新包
  ///
  /// 流程：
  /// 1. 下载更新文件，实时更新下载进度
  /// 2. 下载完成后进行 SHA256 校验
  /// 3. 校验通过后发出 downloaded 状态，UI 可触发安装
  Future<void> startDownload() async {
    final info = _info;
    Logger.info('startDownload 被调用, _info: ${_info?.latest}');

    if (info == null) {
      Logger.error('_info 为 null，无法下载');
      return;
    }

    Logger.info('发送 downloading 状态, progress: 0');
    emit(UpdateState.downloading(progress: 0, info: info));

    // 订阅下载进度
    await _progressSub?.cancel();

    Logger.info('开始订阅进度流');
    _progressSub = _download.progress$.listen(
      (p) {
        final safe = p.isNaN ? 0.0 : p; // 防止 NaN 值
        Logger.info('Cubit 收到下载进度: $safe');
        emit(UpdateState.downloading(progress: safe, info: info));
      },
      onError: (e) {
        Logger.error('进度流错误: $e');
      },
      onDone: () {
        Logger.info('进度流结束');
      },
    );

    try {
      Logger.info('开始执行下载: url=${info.url}, filename=${info.filename}');
      // 执行下载
      final path = await _download(url: info.url, filename: info.filename);
      await _progressSub?.cancel();
      Logger.info('下载返回路径: $path');

      if (path == null) {
        emit(const UpdateState.error(message: '下载失败，请稍后重试'));
        return;
      }

      // 验证文件完整性
      emit(UpdateState.verifying(info: info));

      final ok = await _verify(path, info.sha256);
      if (!ok) {
        emit(UpdateState.checksumFailed(info: info));
        return;
      }

      // 下载并校验成功，UI 可触发安装
      emit(UpdateState.downloaded(path: path, info: info));
    } catch (e) {
      emit(UpdateState.error(message: '下载过程异常：$e'));
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
