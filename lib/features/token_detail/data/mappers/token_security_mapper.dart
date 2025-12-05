import '../../../../data/models/language/language.dart';
import '../../domain/entities/token_security_entity.dart';
import '../models/token_security_model.dart';

extension SecurityItemToEntityMapper on SecurityItemModel {
  SecurityItemEntity toEntity() {
    return SecurityItemEntity(
      title: title ?? Multilingual.empty(),
      description: description ?? Multilingual.empty(),
      isSafe: isSafe,
      type: type,
    );
  }
}

extension TradeTaxToEntityMapper on TradeTaxModel {
  TradeTaxEntity toEntity() {
    return TradeTaxEntity(buyTax: buyTax, sellTax: sellTax);
  }
}

extension TokenSecurityToEntityMapper on TokenSecurityModel {
  TokenSecurityEntity toEntity() {
    return TokenSecurityEntity(
      contractAnalysis: contractAnalysis.map((e) => e.toEntity()).toList(),
      tradeTax: tradeTax?.toEntity() ?? TradeTaxEntity.empty(),
    );
  }
}
