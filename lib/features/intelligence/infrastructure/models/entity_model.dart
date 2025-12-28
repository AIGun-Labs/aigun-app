import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../infrastructure/serialization/converters/dynamic_converter.dart';
import '../../../../utils/validators/token_validator.dart';
import 'chain_model.dart';
import 'stats_model.dart';

part 'entity_model.freezed.dart';
part 'entity_model.g.dart';

DateTime? _dateTimeFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value.toLocal();
  if (value is String) {
    if (value.isEmpty) return null;
    try {
      return DateTime.parse(value).toLocal();
    } catch (e) {
      return null;
    }
  }
  if (value is num) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(
        value.toInt(),
        isUtc: true,
      ).toLocal();
    } catch (e) {
      return null;
    }
  }
  return null;
}

@freezed
sealed class IntelligenceEntityModel with _$IntelligenceEntityModel {
  const IntelligenceEntityModel._(); //  getter

  const factory IntelligenceEntityModel({
    String? id,
    @JsonKey(name: 'entity_id') String? entityId,
    String? name,
    String? symbol,
    String? standard,
    int? decimals,
    @JsonKey(name: 'contract_address') String? contractAddress,
    String? logo,
    @JsonKey(name: 'stats') IntelligenceStatsModel? stats,
    @JsonKey(name: 'chain') IntelligenceChainModel? chain,
    @JsonKey(name: 'created_at', fromJson: _dateTimeFromDynamic)
    DateTime? createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateTimeFromDynamic)
    DateTime? updatedAt,
    @DynamicDoubleConverter() @JsonKey(name: 'score') double? score,
    @JsonKey(name: 'is_native') bool? isNative,
  }) = _IntelligenceEntityModel;

  bool get isNativeToken {
    return isNative ?? TokenValidator.isNative(isNative ?? false);
  }

  bool get shouldShowAddress {
    return TokenValidator.shouldShowAddress(
      isNative ?? false,
      chain?.networkId ?? '',
    );
  }

  bool get shouldShowChainLogo {
    return TokenValidator.shouldShowChainLogo(chain?.slug, logo);
  }

  factory IntelligenceEntityModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceEntityModelFromJson(json);
}
