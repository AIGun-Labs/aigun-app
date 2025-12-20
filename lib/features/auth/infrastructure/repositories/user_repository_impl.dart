import '../../../../core/types/result.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_source.dart';
import '../mappers/auth_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userRemoteSource);
  final UserRemoteSource _userRemoteSource;

  @override
  Future<Result<AuthUserEntity>> getUserInfo() async {
    try {
      final response = await _userRemoteSource.getUserInfo();
      return Result.success(response.toEntity());
    } on Exception catch (e) {
      return Result.failure(e.toString());
    }
  }
}
