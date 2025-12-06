import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../collect/domain/entities/collect_token_entity.dart';
import '../entities/top_token_entity.dart';

extension TopTokenEntityToCollectTokenEntityMapper on TopTokenEntity {
  CollectTokenEntity toCollectToken() {
    return CollectTokenEntity(base: base);
  }

  BaseTokenEntity toTokenEntity() {
    return base;
  }
}
