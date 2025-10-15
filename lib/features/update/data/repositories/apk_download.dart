import 'dart:async';
import 'package:background_downloader/background_downloader.dart';

import '../../domain/repositories/apk_download.dart';

class ApkDownloadRepositoryImpl implements ApkDownloadRepository {
  ApkDownloadRepositoryImpl() {
    _configure();
  }

  final _progressC = StreamController<double>.broadcast();
  DownloadTask? _task;
  StreamSubscription<TaskUpdate>? _sub;

  Future<void> _configure() async {
    await FileDownloader().configure(
      globalConfig: [
        (Config.requestTimeout, const Duration(seconds: 100)),
      ],
    );
  }

  @override
  Stream<double> get progress$ => _progressC.stream;

  @override
  Future<String?> download(
      {required String url, required String filename}) async {
    await _sub?.cancel();
    final task = DownloadTask(
      url: url,
      filename: filename,
      directory: 'updates',
      baseDirectory: BaseDirectory.applicationSupport, // 对应 external-files-path
      allowPause: true,
      retries: 3,
      updates: Updates.statusAndProgress,
    );
    _task = task;
    _sub = FileDownloader().updates.listen((u) async {
      if (u.task.taskId != task.taskId) return;
      if (u is TaskProgressUpdate) _progressC.add(u.progress);
    });

    final result = await FileDownloader().download(task);
    await _sub?.cancel();
    _sub = null;

    if (result.status == TaskStatus.complete) {
      return await task.filePath();
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
