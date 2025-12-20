import '../../../../core/types/result.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class GetUserInfo {
  GetUserInfo(this._repository);
  final UserRepository _repository;

  Future<Result<AuthUserEntity>> call() => _repository.getUserInfo();
}
