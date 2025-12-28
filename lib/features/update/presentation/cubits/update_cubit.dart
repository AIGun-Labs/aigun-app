import 'dart:async';
import 'dart:io';

// import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utils/logger.dart';
import '../../domain/entities/config_entity.dart';
import '../../domain/usecases/can_install_from_unknown_sources.dart';
import '../../domain/usecases/check_for_update_v2.dart';
import '../../domain/usecases/download_update.dart';
import '../../domain/usecases/installer_apk.dart';
import '../../domain/usecases/open_install_settings.dart';
import '../../domain/usecases/verify_checksum.dart';

part 'update_cubit.freezed.dart';
part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit(
    this._check,
    this._download,
    this._verify,
    this._install,
    this._canInstall,
    this._openSettings,
  ) : super(const UpdateState.initial());

  final CheckForUpdateV2 _check; //
  final DownloadUpdate _download; //
  final VerifyChecksum _verify; //
  final InstallerApk _install; //
  final CanInstallFromUnknownSources _canInstall; //
  final OpenInstallSettings _openSettings; //

  StreamSubscription<double>? _progressSub; //
  ConfigEntity? _info; //
  Future<void> checkForUpdate() async {
    if (Platform.isIOS) {
      emit(const UpdateState.iosUnavailable());
      return;
    }
    emit(const UpdateState.checking());

    try {
      final latest = await _check.call();
      print('latestVersion: ${latest?.latest}');
      if (latest == null) {
        emit(const UpdateState.noUpdate());
        return;
      }

      _info = latest;

      emit(UpdateState.available(info: latest, force: latest.force));
    } catch (e) {
      emit(UpdateState.error(message: 'check for update failed: $e'));
    }
  }

  Future<void> startDownload() async {
    if (state is! UpdateAvailable || _info == null) {
      emit(const UpdateState.error(message: 'no update available'));
      return;
    }
    emit(const UpdateState.downloading(progress: 0));
    await _progressSub?.cancel();

    _progressSub = _download.progress$.listen((p) {
      final safe = p.isNaN ? 0.0 : p; //  NaN
      emit(UpdateState.downloading(progress: safe));
    });

    try {
      final path = await _download.call(
        url: _info!.url,
        filename: _info!.filename,
      );

      await _progressSub?.cancel();

      if (path == null) {
        emit(
          const UpdateState.error(
            message: 'download failed, please try again later',
          ),
        );
        return;
      }
      await verifyChecksum(path);
    } catch (e) {
      await _progressSub?.cancel();
      emit(UpdateState.error(message: 'download process exception: $e'));
    }
  }

  Future<void> verifyChecksum(String path) async {
    final ok = await _verify.call(path);
    if (!ok) {
      emit(
        const UpdateState.error(message: 'file integrity verification failed'),
      );
      return;
    }
    await checkCanInstall(path);
  }

  Future<void> checkCanInstall(String path) async {
    final canInstall = await _canInstall.call();
    if (!canInstall) {
      emit(UpdateState.installNeedsPermission(path: path));
      return;
    }

    await installApk(path);
  }

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

  Future<void> openInstallPermissionSettings() async {
    await _openSettings.call();
  }

  Future<void> resumeInstallFromSettings() async {
    final currentState = state;
    if (currentState is UpdateInstallNeedsPermission) {
      final path = currentState.path;

      final canInstall = await _canInstall.call();

      if (canInstall) {
        await installApk(path);
      } else {
        Logger.info(
          'still no permission, staying in installNeedsPermission state',
        );
      }
    }
  }

  @override
  Future<void> close() async {
    await _progressSub?.cancel();
    return super.close();
  }
}
