import '../../../../core/types/result.dart';
import '../entities/auth_result_entity.dart';
import '../entities/auth_token_entity.dart';
import '../entities/auth_user_entity.dart';

/// Auth Repository Interface
///
/// Defines the contract for authentication data operations.
/// This interface is implemented in the infrastructure layer.
abstract class AuthRepository {
  // ==================== Authentication Operations ====================

  /// Send verification code to email
  ///
  /// [email] - The email address to send verification code to
  /// Returns [Result<void>] indicating success or failure
  Future<Result<void>> sendVerificationCode({required String email});

  /// Verify the verification code
  ///
  /// [email] - The email address
  /// [code] - The 6-digit verification code
  /// Returns [Result<AuthResultEntity>] with:
  /// - [AuthResultExistingUser] if user exists and is authenticated
  /// - [AuthResultNewUserRequired] if user needs to register
  Future<Result<AuthResultEntity>> verifyCode({
    required String email,
    required String code,
  });

  /// Register a new user
  ///
  /// [email] - The email address
  /// [code] - The verification code
  /// [nickname] - The user's nickname
  /// [inviteCode] - Optional invite code
  /// Returns [Result<AuthResultEntity>] with [AuthResultRegistered] on success
  Future<Result<AuthResultEntity>> register({
    required String email,
    required String code,
    required String nickname,
    String? inviteCode,
  });

  /// Submit thanks message for invite code
  ///
  /// [messageId] - The selected message ID
  /// [inviteCode] - The invite code used
  Future<Result<void>> submitThanksMessage({
    required int messageId,
    required String inviteCode,
  });

  // ==================== Token Management ====================

  /// Get stored authentication tokens
  Future<AuthTokenEntity?> getStoredTokens();

  /// Save authentication tokens
  Future<void> saveTokens(AuthTokenEntity tokens);

  /// Clear stored tokens (logout)
  Future<void> clearTokens();

  // ==================== User Management ====================

  /// Get stored user information
  Future<AuthUserEntity?> getStoredUser();

  /// Save user information
  Future<void> saveUser(AuthUserEntity user);

  /// Clear stored user information
  Future<void> clearUser();

  /// Clear all auth data (tokens + user)
  Future<void> clearAll();
}
