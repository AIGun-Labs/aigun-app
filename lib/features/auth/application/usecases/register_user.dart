import '../../../../core/types/result.dart';
import '../../domain/entities/auth_result_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Use Case: Register User
///
/// Registers a new user with the provided information.
class RegisterUser {
  final AuthRepository _repository;

  RegisterUser(this._repository);

  /// Execute the use case
  ///
  /// [email] - The email address
  /// [code] - The verification code
  /// [nickname] - The user's nickname (max 20 characters)
  /// [inviteCode] - Optional invite code (max 6 characters)
  /// Returns [Result<AuthResultEntity>] with [AuthResultRegistered] on success
  Future<Result<AuthResultEntity>> call({
    required String email,
    required String code,
    required String nickname,
    String? inviteCode,
  }) async {
    // Validate email
    final trimmedEmail = email.trim().toLowerCase();
    if (trimmedEmail.isEmpty) {
      return Result.failure('Email is required');
    }

    // Validate code
    final trimmedCode = code.trim();
    if (trimmedCode.isEmpty || trimmedCode.length != 6) {
      return Result.failure('Invalid verification code');
    }

    // Validate nickname
    final trimmedNickname = nickname.trim();
    if (trimmedNickname.isEmpty) {
      return Result.failure('Nickname is required');
    }
    if (trimmedNickname.length > 20) {
      return Result.failure('Nickname must be 20 characters or less');
    }

    // Validate invite code if provided
    String? trimmedInviteCode;
    if (inviteCode != null && inviteCode.trim().isNotEmpty) {
      trimmedInviteCode = inviteCode.trim();
      if (trimmedInviteCode.length > 6) {
        return Result.failure('Invite code must be 6 characters or less');
      }
    }

    return _repository.register(
      email: trimmedEmail,
      code: trimmedCode,
      nickname: trimmedNickname,
      inviteCode: trimmedInviteCode,
    );
  }
}
