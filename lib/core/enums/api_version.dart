import 'package:dio/dio.dart';

enum APIVersion {
  v1(1),
  v2(2),
  v3(3),
  v4(4),
  v5(5),
  v6(6),
  v7(7),
  v8(8),
  v9(9),
  v10(10);

  String get version => "v$value";
  final int value;

  Options get options => Options(headers: {
        'X-API-Version': version,
      });

  const APIVersion(this.value);
}
