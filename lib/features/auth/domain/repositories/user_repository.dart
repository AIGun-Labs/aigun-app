import '../../../../core/types/result.dart';
import '../entities/auth_user_entity.dart';

abstract interface class UserRepository {
  Future<Result<AuthUserEntity>> getUserInfo();
}
