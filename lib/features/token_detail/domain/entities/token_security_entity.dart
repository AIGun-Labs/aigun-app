import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'token_security_entity.freezed.dart';

@freezed
class TokenSecurityEntity with _$TokenSecurityEntity {
  const TokenSecurityEntity({
    required this.contractAnalysis,
    required this.tradeTax,
  });
  @override
  final List<SecurityItemEntity> contractAnalysis;
  @override
  final TradeTaxEntity tradeTax;

  int get notSafeCount =>
      contractAnalysis.where((element) => element.isSafe == false).length;

  int get warningCount => contractAnalysis
      .where((element) => element.isSafe == false && element.type == 'risk')
      .length;

  int get riskCount => contractAnalysis
      .where(
        (element) => element.isSafe == false && element.type == 'attention',
      )
      .length;
}

@freezed
class SecurityItemEntity with _$SecurityItemEntity {
  const SecurityItemEntity({
    required this.title,
    required this.description,
    required this.isSafe,
    required this.type,
  });
  @override
  final MultilingualModel title;
  @override
  final MultilingualModel description;
  @override
  final bool isSafe;
  @override
  final String type;
}

@freezed
class TradeTaxEntity with _$TradeTaxEntity {
  const TradeTaxEntity({required this.buyTax, required this.sellTax});

  factory TradeTaxEntity.empty() =>
      const TradeTaxEntity(buyTax: '', sellTax: '');
  @override
  final String buyTax;
  @override
  final String sellTax;
}
