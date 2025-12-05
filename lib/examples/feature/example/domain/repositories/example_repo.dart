import '../../../../../core/types/result.dart';
import '../entities/example_entity.dart';

///

abstract class ExampleRepo {
  ///

  Future<Result<List<ExampleEntity>>> fetchExamples();

  ///

  Future<Result<ExampleEntity>> fetchExampleById(String id);

  ///

  Future<Result<ExampleEntity>> createExample({
    required String name,
    required String description,
  });
}
