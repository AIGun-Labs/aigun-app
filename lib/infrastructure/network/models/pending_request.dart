import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_request.freezed.dart';

@freezed
sealed class PendingRequest with _$PendingRequest {
  const factory PendingRequest.error(RequestOptions options, ErrorInterceptorHandler handler) = _ErrorPendingRequest;
  const factory PendingRequest.request(RequestOptions options, RequestInterceptorHandler handler) =
      _RequestPendingRequest;
  const factory PendingRequest.response(RequestOptions options, ResponseInterceptorHandler handler) =
      _ResponsePendingRequest;
}
