import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  const ApiResponse({
    required this.code,
    required this.msg,
    this.data,
    this.pagination,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
  @JsonKey(defaultValue: 0)
  final int code;
  @JsonKey(defaultValue: '')
  final String msg;
  final T? data;
  final Pagination? pagination;
  bool get isSuccess => code == 0 || code == 200;
  Map<String, dynamic> toJson(T Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable()
class Pagination {
  const Pagination({
    this.page = 1,
    this.size = 10,
    this.totalPage = 0,
    this.count = 0,
    this.hasNext = false,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  final int page;
  final int size;
  @JsonKey(name: 'total_page')
  final int totalPage;
  final int count;
  @JsonKey(name: 'has_next')
  final bool hasNext;
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
