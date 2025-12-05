// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  code: (json['code'] as num?)?.toInt() ?? 0,
  msg: json['msg'] as String? ?? '',
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.msg,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'pagination': instance.pagination,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_Pagination _$PaginationFromJson(Map<String, dynamic> json) => _Pagination(
  page: (json['page'] as num?)?.toInt() ?? 1,
  size: (json['size'] as num?)?.toInt() ?? 10,
  totalPage: (json['total_page'] as num?)?.toInt() ?? 0,
  count: (json['count'] as num?)?.toInt() ?? 0,
  hasNext: json['has_next'] as bool? ?? false,
);

Map<String, dynamic> _$PaginationToJson(_Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'total_page': instance.totalPage,
      'count': instance.count,
      'has_next': instance.hasNext,
    };
