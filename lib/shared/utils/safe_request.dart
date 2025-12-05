Future<T?> safeRequest<T>(
  Future<T> Function() request, {
  String? feature,
  Map<String, dynamic>? extra,
  Function()? onFinally,
  Function(Object e, StackTrace s)? onError,
  Function()? onSuccess,
}) async {
  try {
    return await request();
  } catch (e, s) {
    return null;
  } finally {
    onFinally?.call();
  }
}
