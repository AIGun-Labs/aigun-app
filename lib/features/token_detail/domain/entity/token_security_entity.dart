import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';

part 'token_security_entity.freezed.dart';

@freezed
class TokenSecurityEntity with _$TokenSecurityEntity {
  @override
  final List<SecurityItemEntity> contractAnalysis;
  @override
  final TradeTaxEntity tradeTax;

  const TokenSecurityEntity({
    required this.contractAnalysis,
    required this.tradeTax,
  });

  int get riskCount =>
      contractAnalysis.where((element) => element.isSafe == false).length;
}

@freezed
class SecurityItemEntity with _$SecurityItemEntity {
  @override
  final Multilingual title;
  @override
  final Multilingual description;
  @override
  final bool isSafe;
  @override
  final String type;

  const SecurityItemEntity({
    required this.title,
    required this.description,
    required this.isSafe,
    required this.type,
  });
}

@freezed
class TradeTaxEntity with _$TradeTaxEntity {
  @override
  final String buyTax;
  @override
  final String sellTax;
  const TradeTaxEntity({required this.buyTax, required this.sellTax});

  factory TradeTaxEntity.empty() =>
      const TradeTaxEntity(buyTax: '', sellTax: '');
}
