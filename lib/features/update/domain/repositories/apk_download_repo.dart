abstract class ApkDownloadRepository {
  /// 下载进度 0..1
  Stream<double> get progress$;

  /// 返回本地路径（成功）或 null（失败）
  Future<String?> download({required String url, required String filename});

  Future<void> pause();
  Future<void> resume();
  Future<void> cancel();
}
