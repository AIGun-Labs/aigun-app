import '../../features/auth/infrastructure/models/auth_user_model.dart';

abstract interface class SecureUserStorageService {
  Future<void> writeUserInfo(AuthUserModel user);
  Future<AuthUserModel> readUserInfo();
  Future<void> clearUserInfo();
}
