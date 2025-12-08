import '../../../../core/types/result.dart';
import '../../domain/repositories/auth_repository.dart';

/// Use Case: Submit Thanks Message
///
/// Records the thanks message when a user registers with an invite code.
class SubmitThanksMessage {
  final AuthRepository _repository;

  SubmitThanksMessage(this._repository);

  /// Execute the use case
  ///
  /// [messageId] - The ID of the selected thanks message
  /// [inviteCode] - The invite code that was used
  /// Returns [Result<void>] indicating success or failure
  Future<Result<void>> call({
    required int messageId,
    required String inviteCode,
  }) async {
    // Validate message ID
    if (messageId < 0) {
      return Result.failure('Invalid message ID');
    }

    // Validate invite code
    final trimmedInviteCode = inviteCode.trim();
    if (trimmedInviteCode.isEmpty) {
      return Result.failure('Invite code is required');
    }

    return _repository.submitThanksMessage(
      messageId: messageId,
      inviteCode: trimmedInviteCode,
    );
  }
}
