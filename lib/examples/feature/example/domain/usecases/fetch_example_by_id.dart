import '../../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

///

class FetchExampleById {
  final ExampleRepo _repository;

  ///

  FetchExampleById(this._repository);

  ///

  Future<Result<ExampleEntity>> call(String id) async {
    return await _repository.fetchExampleById(id);
  }
}
