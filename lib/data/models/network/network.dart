import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/enums/server_healthy_status.dart';

part 'network.freezed.dart';
part 'network.g.dart';

@freezed
sealed class NetworkStatus with _$NetworkStatus {
  const factory NetworkStatus({
    ServerHealthyStatus? status,
    String? details,
    @JsonKey(name: 'response_time') int? responseTime,
  }) = _NetworkStatus;

  factory NetworkStatus.fromJson(Map<String, dynamic> json) =>
      _$NetworkStatusFromJson(json);
}

@freezed
sealed class NetworkResult with _$NetworkResult {
  const factory NetworkResult({
    ServerHealthyStatus? status,
    int? timestamp,
    NetworkStatus? database,
    NetworkStatus? redis,
    NetworkStatus? rabbitmq,
  }) = _NetworkResult;

  factory NetworkResult.fromJson(Map<String, dynamic> json) =>
      _$NetworkResultFromJson(json);
}
