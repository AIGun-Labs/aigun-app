import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class QueuedRequest extends HiveObject {
  @HiveField(0)
  final String method;
  @HiveField(1)
  final String path;
  @HiveField(2)
  final dynamic data;
  @HiveField(3)
  final Map<String, dynamic>? queryParameters;
  @HiveField(4)
  final Map<String, dynamic>? headers;

  QueuedRequest({
    required this.method,
    required this.path,
    this.data,
    this.queryParameters,
    this.headers,
  });
}
