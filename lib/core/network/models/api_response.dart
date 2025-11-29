import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();
  const factory ApiResponse({
    @Default(0) int code,
    @Default('') String msg,
    T? data,
    Pagination? pagination,
  }) = _ApiResponse<T>;

  /// 判断业务逻辑是否正确
  bool get isSuccess => code == 0 || code == 200;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

/// 分页数据模型
@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    @Default(1) int page,
    @Default(10) int size,
    @JsonKey(name: 'total_page') @Default(0) int totalPage, // 映射下划线字段
    @Default(0) int count,
    @JsonKey(name: 'has_next') @Default(false) bool hasNext, // 映射下划线字段
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
