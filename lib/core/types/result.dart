import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T value) = _Success<T>;
  const factory Result.loading() = _Loading<T>;
  const factory Result.failure(String message) = _Failure<T>;

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  String? get errorMessage => whenOrNull(failure: (message) => message);
}
