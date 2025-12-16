import '../../../../core/types/result.dart';
import '../../../../infrastructure/network/error/app_exception.dart';
import '../../domain/constants/auth_error_codes.dart';
import '../../domain/entities/auth_result_entity.dart';
import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_source.dart';
import '../datasources/auth_remote_source.dart';
import '../mappers/auth_mapper.dart';

/// Auth Repository Implementation
///
/// Implements the AuthRepository interface by coordinating between
/// remote and local data sources.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteSource, this._localSource);
  final AuthRemoteSource _remoteSource;
  final AuthLocalSource _localSource;

  // ==================== Authentication Operations ====================

  @override
  Future<Result<void>> sendVerificationCode({required String email}) async {
    try {
      await _remoteSource.sendVerificationCode(email);
      return Result.success(null);
    } on AppException catch (e) {
      if (e is BusinessException) {
        return Result.be(e);
      }
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<AuthResultEntity>> verifyCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _remoteSource.verifyCode(email, code);

      if (response.hasValidAuth) {
        // Save tokens and user to local storage
        await _localSource.saveTokens(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        await _localSource.saveUser(response.user!);

        return Result.success(
          AuthResultEntity.existingUser(
            user: response.toUserEntity()!,
            tokens: response.toTokenEntity()!,
          ),
        );
      }

      // No user data means new user required
      return Result.success(const AuthResultEntity.newUserRequired());
    } on AppException catch (e) {
      if (e is BusinessException) {
        // Special case: user not exists means need to register
        if (AuthErrorCodes.isNewUserRequired(e.code!)) {
          return Result.success(const AuthResultEntity.newUserRequired());
        }

        return Result.be(e);
      }
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<AuthResultEntity>> register({
    required String email,
    required String code,
    required String nickname,
    String? inviteCode,
  }) async {
    try {
      final response = await _remoteSource.register(
        email: email,
        verifyCode: code,
        nickname: nickname,
        inviteCode: inviteCode,
      );

      if (response.hasValidAuth) {
        // Save tokens and user to local storage
        await _localSource.saveTokens(
          accessToken: response.accessToken!,
          refreshToken: response.refreshToken!,
        );
        await _localSource.saveUser(response.user!);

        return Result.success(
          AuthResultEntity.registered(
            user: response.toUserEntity()!,
            tokens: response.toTokenEntity()!,
            hasInviteCode: inviteCode?.isNotEmpty ?? false,
          ),
        );
      }

      return Result.failure('Registration failed: Invalid response');
    } on AppException catch (e) {
      if (e is BusinessException) {
        return Result.be(e);
      }
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> submitThanksMessage({
    required int messageId,
    required String inviteCode,
  }) async {
    try {
      await _remoteSource.submitThanksMessage(messageId, inviteCode);
      return Result.success(null);
    } on AppException catch (e) {
      if (e is BusinessException) {
        return Result.be(e);
      }
      return Result.failure(e.message);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  // ==================== Token Management ====================

  @override
  Future<AuthTokenEntity?> getStoredTokens() async {
    final (accessToken, refreshToken) = await _localSource.getTokens();
    if (accessToken == null || refreshToken == null) return null;

    return AuthTokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> saveTokens(AuthTokenEntity tokens) async {
    await _localSource.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<void> clearTokens() async {
    await _localSource.clearTokens();
  }

  // ==================== User Management ====================

  @override
  Future<AuthUserEntity?> getStoredUser() async {
    final userModel = await _localSource.getUser();
    return userModel?.toEntity();
  }

  @override
  Future<void> saveUser(AuthUserEntity user) async {
    await _localSource.saveUser(user.toModel());
  }

  @override
  Future<void> clearUser() async {
    await _localSource.clearUser();
  }

  @override
  Future<void> clearAll() async {
    await _localSource.clearAll();
  }
}
