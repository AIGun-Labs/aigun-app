import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import '../../../../utils/logger.dart';

import '../../domain/repositories/apk_download.dart';
import '../../utils/notification_permission.dart';

class ApkDownloadRepositoryImpl implements ApkDownloadRepository {
  ApkDownloadRepositoryImpl() {
    _configure();
  }

  final _progressC = StreamController<double>.broadcast();
  DownloadTask? _task;

  Future<void> _configure() async {
    await FileDownloader().configure(
      globalConfig: [
        (Config.requestTimeout, const Duration(seconds: 100)),
      ],
    );
    FileDownloader().configureNotification(
      running: const TaskNotification(
        'AIGun',
        '{progress}',
      ),
      progressBar: true,
    );
  }

  @override
  Stream<double> get progress$ => _progressC.stream;

  @override
  Future<String?> download(
      {required String url, required String filename}) async {
    final hasPermission = await NotificationPermission.request();
    if (!hasPermission) {
      Logger.error('未获得通知权限，通知可能无法显示');
    }

    final task = DownloadTask(
      url: url,
      filename: filename,
      directory: 'updates',
      baseDirectory: BaseDirectory.applicationSupport,
      allowPause: true,
      retries: 3,
      updates: Updates.statusAndProgress,
      displayName: 'AIGun upgrade',
      requiresWiFi: false,
    );
    _task = task;

    final result =
        await FileDownloader().download(task, onProgress: (progress) {
      _progressC.add(progress);
    });

    if (result.status == TaskStatus.complete) {
      final path = await task.filePath();
      return path;
    }

    return null;
  }

  @override
  Future<void> pause() async {
    final t = _task;
    if (t != null) await FileDownloader().pause(t);
  }

  @override
  Future<void> resume() async {
    final t = _task;
    if (t != null) await FileDownloader().resume(t);
  }

  @override
  Future<void> cancel() async {
    final t = _task;
    if (t != null) {
      await FileDownloader().cancelTaskWithId(t.taskId);
    }
  }
}
