import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../repositories/token_repository.dart';

class GetNativeTokens {
  final TokenRepository _repository;

  GetNativeTokens(this._repository);

  Future<Result<List<TokenEntity>>> call() {
    return _repository.getNativeTokens();
  }
}
