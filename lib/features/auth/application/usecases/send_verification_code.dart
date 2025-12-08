import '../../../../core/types/result.dart';
import '../../domain/repositories/auth_repository.dart';

/// Use Case: Send Verification Code
///
/// Sends a verification code to the provided email address.
class SendVerificationCode {
  final AuthRepository _repository;

  SendVerificationCode(this._repository);

  /// Execute the use case
  ///
  /// [email] - The email address to send verification code to
  /// Returns [Result<void>] indicating success or failure
  Future<Result<void>> call({required String email}) async {
    // Basic email validation
    final trimmedEmail = email.trim().toLowerCase();
    if (trimmedEmail.isEmpty) {
      return Result.failure('Email is required');
    }

    // Simple email format check
    if (!_isValidEmailFormat(trimmedEmail)) {
      return Result.failure('Invalid email format');
    }

    return _repository.sendVerificationCode(email: trimmedEmail);
  }

  bool _isValidEmailFormat(String email) {
    // Basic email format validation
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
