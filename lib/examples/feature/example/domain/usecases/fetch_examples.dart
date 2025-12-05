import '../../../../../core/types/result.dart';
import '../entities/example_entity.dart';
import '../repositories/example_repo.dart';

///

class FetchExamples {
  final ExampleRepo _repository;

  ///

  FetchExamples(this._repository);

  ///

  Future<Result<List<ExampleEntity>>> call() async {
    return await _repository.fetchExamples();
  }
}
