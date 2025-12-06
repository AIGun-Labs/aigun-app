import '../../../../core/types/result.dart';
import '../entities/option_tab_entity.dart';
import '../repositories/option_tab_repo.dart';

class GetOptionTab {
  final OptionTabRepo _repository;

  GetOptionTab(this._repository);

  Future<Result<OptionTabEntity>> call() async {
    return await _repository.fetchOptionTab();
  }
}
