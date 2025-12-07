import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_datas_entity.freezed.dart';

/// Extra Datas Entity
///
/// Represents additional data flags for intelligence
@freezed
sealed class ExtraDatasEntity with _$ExtraDatasEntity {
  const factory ExtraDatasEntity({
    @Default(false) bool isAlpha,
  }) = _ExtraDatasEntity;
}
