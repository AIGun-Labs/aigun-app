class RetryUtils {
  static Future<T> executeWithRetry<T>(
      {required Future<T> Function() operation,
      int maxRetries = 3,
      Duration retryDelay = const Duration(seconds: 1),
      bool Function(T?)? shouldRetry,
      Function(int retryCount)? onRetry}) async {
    // 已重试的次数
    var retryCount = 0;

// 重试次数小于最大重试次数
    while (retryCount < maxRetries) {
      try {
        // 执行操作
        final result = await operation();

// 如果结果不为空且不需要重试
        if (result != null && (shouldRetry == null || !shouldRetry(result))) {
          return result;
        }

        // 重试次数加1
        retryCount++;

        if (retryCount < maxRetries) {
          // 重试回调
          onRetry?.call(retryCount);
          await Future.delayed(retryDelay);
        }
      } catch (e) {
        // 重试次数加1
        retryCount++;
        if (retryCount < maxRetries) {
          // 重试回调
          onRetry?.call(retryCount);
          await Future.delayed(retryDelay);
        } else {
          rethrow;
        }
      }
    }
    throw Exception("Max retries reached");
  }

  static Future<void> executeWithRetryAndCallback<T>(
      {required Future<T> Function() operation,
      required Function(T result) onSuccess,
      required Function(String? error) onError,
      int maxRetries = 3,
      Duration retryDelay = const Duration(seconds: 1),
      bool Function(T?)? shouldRetry}) async {
    try {
      final result = await executeWithRetry(
          operation: operation,
          maxRetries: maxRetries,
          retryDelay: retryDelay,
          shouldRetry: shouldRetry);

      onSuccess(result);
    } catch (e) {
      onError(e.toString());
    }
  }
}
