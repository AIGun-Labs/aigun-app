import '../../data/services/sentry_service.dart';

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
    SentryService().reportError(e, s,
        tags: feature != null ? {'feature': feature} : null,
        extra: extra ?? {});
    return null;
  } finally {
    onFinally?.call();
  }
}
