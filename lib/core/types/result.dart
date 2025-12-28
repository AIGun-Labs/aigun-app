import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/network/error/app_exception.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T value) = _Success<T>; //
  const factory Result.loading() = _Loading<T>; // ：
  const factory Result.failure(String message) = _Failure<T>; // ， Failure
  const factory Result.be(BusinessException be) = _Be<T>;
  const factory Result.cancelled(String message) = _Cancelled<T>;

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  T? get value => maybeWhen(success: (value) => value, orElse: () => null);

  String? get errorMessage =>
      maybeWhen(failure: (message) => message, orElse: () => null);
}
