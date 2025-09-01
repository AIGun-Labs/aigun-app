import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_state.freezed.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState({
    @Default(0) int countdown,
    @Default(false) bool isResendLoading,
    String? errorCode,
  }) = _VerificationState;
}
