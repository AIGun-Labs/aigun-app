import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/language/language.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../utils/format/profit.dart';

part 'token_info_entity.freezed.dart';

@Freezed()
class TokenInfoEntity with _$TokenInfoEntity {
  @override
  final String holders;

  @override
  final String highestIncreaseRate;

  @override
  final bool isMainstream;

  @override
  final Multilingual? narrative;

  @override
  final BaseTokenEntity base;

  const TokenInfoEntity({
    required this.base,
    required this.holders,
    required this.highestIncreaseRate,
    required this.isMainstream,
    required this.narrative,
  });
}

// typedef TokenInfoEntity = BaseTokenEntity;

extension TokenInfoEntityX on TokenInfoEntity {
  String get hodlersValue {
    if (isMainstream && (int.tryParse(holders) ?? 0) == 0) {
      return '--';
    }
    return holders;
  }

  String get increaserate {
    if (highestIncreaseRate.isEmpty) return ProfitFormatter.format('0');
    final parsed = highestIncreaseRate.replaceAll('%', '');
    return ProfitFormatter.format(parsed);
  }
}
