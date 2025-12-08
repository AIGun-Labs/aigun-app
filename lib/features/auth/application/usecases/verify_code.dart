import '../../../../core/types/result.dart';
import '../../domain/entities/auth_result_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Use Case: Verify Code
///
/// Verifies the verification code sent to email.
/// Returns different results based on whether user exists or needs registration.
class VerifyCode {
  final AuthRepository _repository;

  VerifyCode(this._repository);

  /// Execute the use case
  ///
  /// [email] - The email address
  /// [code] - The 6-digit verification code
  /// Returns [Result<AuthResultEntity>]:
  /// - [AuthResultExistingUser] if user exists and authenticated
  /// - [AuthResultNewUserRequired] if user needs to register
  Future<Result<AuthResultEntity>> call({
    required String email,
    required String code,
  }) async {
    // Validate email
    final trimmedEmail = email.trim().toLowerCase();
    if (trimmedEmail.isEmpty) {
      return Result.failure('Email is required');
    }

    // Validate code format (6 digits)
    final trimmedCode = code.trim();
    if (!_isValidCodeFormat(trimmedCode)) {
      return Result.failure('Invalid verification code format');
    }

    return _repository.verifyCode(
      email: trimmedEmail,
      code: trimmedCode,
    );
  }

  bool _isValidCodeFormat(String code) {
    // Code should be exactly 6 digits
    return code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code);
  }
}
