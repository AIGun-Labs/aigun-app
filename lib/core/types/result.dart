import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T value) = _Success<T>; // 成功
  const factory Result.loading() = _Loading<T>; // 可选：加载中
  const factory Result.failure(String message) = _Failure<T>; // 失败，带 Failure

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  String? get errorMessage => whenOrNull(failure: (message) => message);
}
