import '../../../../core/types/result.dart';
import '../repositories/language_repo.dart';

class SaveFollowSystem {
  SaveFollowSystem(this._repo);
  final LanguageRepo _repo;

  Future<Result<void>> call(bool followSystem) =>
      _repo.setFollowSystem(followSystem);
}
