class RetryUtils {
  static Future<T> executeWithRetry<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
    bool Function(T?)? shouldRetry,
    Function(int retryCount)? onRetry,
  }) async {
    var retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final result = await operation();

        if (result != null && (shouldRetry == null || !shouldRetry(result))) {
          return result;
        }

        retryCount++;

        if (retryCount < maxRetries) {
          onRetry?.call(retryCount);
          await Future.delayed(retryDelay);
        }
      } catch (e) {
        retryCount++;
        if (retryCount < maxRetries) {
          onRetry?.call(retryCount);
          await Future.delayed(retryDelay);
        } else {
          rethrow;
        }
      }
    }
    throw Exception("Max retries reached");
  }

  static Future<void> executeWithRetryAndCallback<T>({
    required Future<T> Function() operation,
    required Function(T result) onSuccess,
    required Function(String? error) onError,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
    bool Function(T?)? shouldRetry,
  }) async {
    try {
      final result = await executeWithRetry(
        operation: operation,
        maxRetries: maxRetries,
        retryDelay: retryDelay,
        shouldRetry: shouldRetry,
      );

      onSuccess(result);
    } catch (e) {
      onError(e.toString());
    }
  }
}
