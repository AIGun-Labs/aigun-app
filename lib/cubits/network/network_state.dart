import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_state.freezed.dart';

@freezed
class NetworkState with _$NetworkState {
  const factory NetworkState({
    bool? isConnected,
    bool? isServicesHealthy,
  }) = _NetworkState;
}
