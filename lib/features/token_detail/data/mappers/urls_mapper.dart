import '../../domain/entity/urls_entity.dart';
import '../models/urls_model.dart';

extension UrlsToEntityMapper on UrlsModel {
  UrlsEntity toEntity() {
    return UrlsEntity(
      discord: discord,
      website: website,
      github: github,
      x: x,
      whitepaper: whitepaper,
      reddit: reddit,
      telegram: telegram,
    );
  }
}
