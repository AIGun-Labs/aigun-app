import '../../domain/entities/example_entity.dart';
import '../models/example_model.dart';

///

extension ExampleMapper on ExampleModel {
  ///

  ExampleEntity toEntity() {
    return ExampleEntity(id: id, name: name, description: description);
  }
}

extension ExampleEntityMapper on ExampleEntity {
  ///

  ExampleModel toModel() {
    return ExampleModel(id: id, name: name, description: description);
  }
}
