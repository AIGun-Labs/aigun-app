/// Auth Business Error Codes
///
/// These codes are returned by the backend API for various auth-related errors.
abstract class AuthErrorCodes {
  // ==================== Verification Code Related ====================

  /// Verification code has expired
  static const int codeExpired = 200102;

  /// Verification code is invalid
  static const int codeInvalid = 200103;

  /// Sending verification code too frequently
  static const int sendCodeTooFrequently = 200108;

  /// Too many verification code requests
  static const int sendCodeTooMany = 200109;

  /// Email format is invalid
  static const int emailInvalid = 200110;

  // ==================== User Related ====================

  /// User does not exist (need to register)
  static const int userNotExists = 200200;

  /// User already exists
  static const int userExists = 200201;

  // ==================== Registration Related ====================

  /// Invite code is invalid
  static const int inviteCodeInvalid = 200205;

  /// Failed to create wallet
  static const int createWalletFail = 200116;

  /// Wallet user already exists
  static const int walletUserExists = 200117;

  /// Wallet PIN is invalid
  static const int walletPinInvalid = 200118;

  /// Helper method to check if code indicates user needs registration
  static bool isNewUserRequired(int code) => code == userNotExists;

  /// Helper method to check if code indicates user already exists
  static bool isExistingUser(int code) => code == userExists;

  /// Helper method to check if code is related to verification code issues
  static bool isCodeError(int code) =>
      code == codeExpired ||
      code == codeInvalid ||
      code == sendCodeTooFrequently ||
      code == sendCodeTooMany;
}
