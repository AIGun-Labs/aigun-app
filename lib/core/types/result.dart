import 'package:freezed_annotation/freezed_annotation.dart';

import '../custom_exceptions.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T value) = _Success<T>; // 成功
  const factory Result.loading() = _Loading<T>; // 可选：加载中
  const factory Result.failure(String message) = _Failure<T>; // 失败，带 Failure
  const factory Result.be(BusinessException be) = _Be<T>;

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  T? get value => maybeWhen(success: (value) => value, orElse: () => null);

  String? get errorMessage =>
      maybeWhen(failure: (message) => message, orElse: () => null);
}
