import '../../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

///

class CreateExample {
  final ExampleRepo _repository;

  ///

  CreateExample(this._repository);

  ///

  Future<Result<ExampleEntity>> call({
    required String name,
    required String description,
  }) async {
    return await _repository.createExample(
      name: name,
      description: description,
    );
  }
}
