import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
sealed class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();
  const factory ApiResponse({
    @Default(0) int code,
    @Default('') String msg,
    T? data,
    Pagination? pagination,
  }) = _ApiResponse<T>;

  bool get isSuccess => code == 0 || code == 200;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

@freezed
sealed class Pagination with _$Pagination {
  const factory Pagination({
    @Default(1) int page,
    @Default(10) int size,
    @JsonKey(name: 'total_page') @Default(0) int totalPage,
    @Default(0) int count,
    @JsonKey(name: 'has_next') @Default(false) bool hasNext,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
