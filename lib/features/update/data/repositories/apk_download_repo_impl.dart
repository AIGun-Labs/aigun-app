import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';

import '../../../../utils/logger.dart';
import '../../domain/repositories/apk_download_repo.dart';

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
    // create download task
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
    _progressC.add(0.0);

    //check if file exists
    final path = await task.filePath();
    final file = File(path);
    if (await file.exists()) {
      Logger.info('file already exists: $path');
      _progressC.add(1.0);
      return path;
    }

    Logger.info('downloading file: $path');
    // download file
    final result =
        await FileDownloader().download(task, onProgress: (progress) {
      _progressC.add(progress);
    });

    if (result.status == TaskStatus.complete) {
      Logger.info('download complete: $path');
      _progressC.add(1.0);
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
