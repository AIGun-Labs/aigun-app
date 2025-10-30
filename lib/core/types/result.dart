import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.data(T value) = _Data<T>; // 成功
  const factory Result.loading() = _Loading<T>; // 可选：加载中
  const factory Result.error(String message) = _Error<T>; // 失败，带 Failure
}
