import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_step_state.freezed.dart';

/// Profile Step Status - Sealed union for profile step states
@freezed
sealed class ProfileStepStatus with _$ProfileStepStatus {
  const factory ProfileStepStatus.initial() = ProfileStepInitial;
  const factory ProfileStepStatus.loading() = ProfileStepLoading;
  const factory ProfileStepStatus.success() = ProfileStepSuccess;
  const factory ProfileStepStatus.error(String message, {int? errorCode}) =
      ProfileStepError;
}

/// Profile Step State
@freezed
sealed class ProfileStepState with _$ProfileStepState {
  const ProfileStepState._();

  const factory ProfileStepState({
    /// Nickname input
    @Default('') String nickname,

    /// Invite code input (optional)
    @Default('') String inviteCode,

    /// Whether user has agreed to terms
    @Default(false) bool hasAgreedToTerms,

    /// Current status
    @Default(ProfileStepStatus.initial()) ProfileStepStatus status,

    /// Error message
    String? errorMessage,

    /// Error code from business exception
    int? errorCode,

    /// Selected thanks message ID (for invite code flow)
    @Default(0) int thanksMessageId,
  }) = _ProfileStepState;

  /// Check if currently registering
  bool get isRegistering => status is ProfileStepLoading;

  /// Check if registration was successful
  bool get isSuccess => status is ProfileStepSuccess;

  /// Check if there is an error
  bool get hasError => status is ProfileStepError;

  /// Check if nickname is valid (non-empty, max 20 chars)
  bool get isNicknameValid =>
      nickname.trim().isNotEmpty && nickname.trim().length <= 20;

  /// Check if invite code is valid (empty or max 6 chars)
  bool get isInviteCodeValid =>
      inviteCode.isEmpty || inviteCode.trim().length <= 6;

  /// Check if has invite code
  bool get hasInviteCode => inviteCode.trim().isNotEmpty;

  /// Check if form is valid
  bool get isFormValid =>
      isNicknameValid && isInviteCodeValid && hasAgreedToTerms;

  /// Check if can submit
  bool get canSubmit => isFormValid && !isRegistering;
}
