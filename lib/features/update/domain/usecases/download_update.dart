import '../repositories/apk_download_repo.dart';

class DownloadUpdate {
  final ApkDownloadRepository repo;
  DownloadUpdate(this.repo);

  Stream<double> get progress$ => repo.progress$;

  Future<String?> call({required String url, required String filename}) {
    return repo.download(url: url, filename: filename);
  }

  Future<void> pause() => repo.pause();
  Future<void> resume() => repo.resume();
  Future<void> cancel() => repo.cancel();
}
