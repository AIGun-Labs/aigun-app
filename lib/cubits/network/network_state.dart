import "package:freezed_annotation/freezed_annotation.dart";

part 'network_state.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.network(String message) = _NetworkFailure;
  const factory Failure.business(int code, String message) = _BusinessFailure;
}

@freezed
sealed class NetworkState<T> with _$NetworkState<T> {
  const factory NetworkState.initial() = _Initial;
  const factory NetworkState.loading() = _Loading;
  const factory NetworkState.success(T data) = _Success<T>;
  const factory NetworkState.error(Failure failure) = _Error;
}
