import 'package:hive/hive.dart';

import 'queued_request.dart';

class QueuedRequestAdapter extends TypeAdapter<QueuedRequest> {
  @override
  final int typeId = 0;

  @override
  QueuedRequest read(BinaryReader reader) {
    final String method = reader.read() as String;
    final String path = reader.read() as String;
    final dynamic data = reader.read();
    final Map<String, dynamic>? queryParameters =
        (reader.read() as Map?)?.cast<String, dynamic>();
    final Map<String, dynamic>? headers =
        (reader.read() as Map?)?.cast<String, dynamic>();

    return QueuedRequest(
      method: method,
      path: path,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  void write(BinaryWriter writer, QueuedRequest obj) {
    writer
      ..write(obj.method)
      ..write(obj.path)
      ..write(obj.data)
      ..write(obj.queryParameters)
      ..write(obj.headers);
  }
}
