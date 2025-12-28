abstract class ApkDownloadRepo {
  Stream<double> get progress$;
  Future<String?> download({required String url, required String filename});

  Future<void> pause();
  Future<void> resume();
  Future<void> cancel();
}
