import 'package:freezed_annotation/freezed_annotation.dart';

part "network.freezed.dart";
part 'network.g.dart';

@freezed
class NetworkStatus with _$NetworkStatus {
  const factory NetworkStatus({
    String? status,
    String? details,
    @JsonKey(name: "response_time") String? responseTime,
  }) = _NetworkStatus;

  factory NetworkStatus.fromJson(Map<String, dynamic> json) =>
      _$NetworkStatusFromJson(json);
}

@freezed
class NetworkResult with _$NetworkResult {
  const factory NetworkResult({
    NetworkStatus? status,
    String? timestamp,
    NetworkStatus? database,
    NetworkStatus? redis,
    NetworkStatus? rabbitmq,
  }) = _NetworkResult;

  factory NetworkResult.fromJson(Map<String, dynamic> json) =>
      _$NetworkResultFromJson(json);
}
